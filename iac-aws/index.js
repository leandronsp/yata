"use strict";

const pulumi = require("@pulumi/pulumi");
const webserver = require("./webserver.js");

let webInstance = webserver.createInstance("playground-webserver", "t3.micro");

exports.webUrl = pulumi.interpolate `http://${webInstance.publicDns}`;
