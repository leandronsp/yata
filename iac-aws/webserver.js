"use strict";

const aws = require("@pulumi/aws");
const pulumi = require("@pulumi/pulumi");

let config = new pulumi.Config();

let securityGroupSsh = new aws.ec2.SecurityGroup("ssh-from-allowed-ip", {
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

let securityGroupHttp = new aws.ec2.SecurityGroup("http", {
  ingress: [
    { protocol: "tcp", fromPort: 80, toPort: 80, cidrBlocks: ["0.0.0.0/0"] },
    { protocol: "tcp", fromPort: 443, toPort: 443, cidrBlocks: ["0.0.0.0/0"] },
  ],
  egress: [
    { fromPort: 0, toPort: 0, protocol: "-1", cidrBlocks: ["0.0.0.0/0"] },
  ],
  tags: {
    Name: "http",
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

exports.createInstance = function(name, size) {
  return new aws.ec2.Instance(name, {
    tags: { Name: name },
    instanceType: size,
    vpcSecurityGroupIds: [defaultSecurityGroup.id, securityGroupSsh.id, securityGroupHttp.id],
    ami: ami.id,
    keyName: keyPair.keyName,
  });
}
