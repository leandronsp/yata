"use string";

const aws = require("@pulumi/aws");
const pulumi = require("@pulumi/pulumi");

let config = new pulumi.Config();

let securityGroup = new aws.ec2.SecurityGroup("ssh-from-allowed-ip", {
  ingress: [
    { protocol: "tcp", fromPort: 22, toPort: 22, cidrBlocks: [config.require("ssh-from-ip")] },
  ],
  egress: [
    { fromPort: 0, toPort: 0, protocol: "-1", cidrBlocks: ["0.0.0.0/0"] },
  ],
  tags: {
    Name: "ssh-from-allowed-ip",
  }
});

let keyPair = new aws.ec2.KeyPair("playground-keypair", {
  publicKey: config.requireSecret("ssh-public-key"),
});

let ami = pulumi.output(aws.ec2.getAmi({
  filters: [
    { name: "name", values: ["amzn2-ami-hvm-*"] },
  ],
  owners: ["137112412989"], // Amazon (public image)
  mostRecent: true,
}));

let defaultSecurityGroup = pulumi.output(aws.ec2.getSecurityGroup({
  name: "default",
}));

let server = new aws.ec2.Instance("playgroup-webserver", {
  instanceType: "t3.micro",
  vpcSecurityGroupIds: [defaultSecurityGroup.id, securityGroup.id],
  ami: ami.id,
  keyName: keyPair.keyName,
  tags: {
    Name: "playground-webserver",
  },
});

exports.publicIp = server.publicIp;
exports.publicHostName = server.publicDns;
