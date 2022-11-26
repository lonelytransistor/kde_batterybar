#!/usr/bin/env python3
import argparse, os, hashlib, re

class Compiler:
    BUF_SIZE = 65536
    def __init__(self):
        self.parser = argparse.ArgumentParser(
                prog = "PlasmoidCompiler",
                description = "Compiles plasmoid data into a .tar.gz, .plasmoid and an ArchLinux package from the provided source code.")
        self.parser.add_argument("--version", type=str, required=True, help="Version name from github.")
        self.parser.add_argument("--name", type=str, required=True,    help="Main folder and plasmoid name.")
        self.parser.add_argument("--pkg", type=str, required=True,     help="ArchLinux package name.")
        self.parser.add_argument("--url", type=str, required=True,     help="Full github url.")
        self.parser.add_argument("output", type=str,                   help="Output folder.")
        self.config = vars(self.parser.parse_args())
        self.config.update({"version": re.search(r'v([0-9.]+)', self.config["version"]).group(1)})

        self.replaceData = {
            "#VERSION#": self.config["version"],
            "#NAME#":    self.config["name"],
            "#URL#":     self.config["url"],
            "#PKG#":     self.config["pkg"],
            "#INSTALLS#":self.getInstalls()
            }
        self.pathsData = {
            "metadata.json":    self.config["output"] + "/" + self.config["name"] + "/metadata.json",
            "metadata.desktop": self.config["output"] + "/" + self.config["name"] + "/metadata.desktop",
            "PKGBUILD":         self.config["output"] + "/PKGBUILD",
            ".tar.gz":          self.config["output"] + "/" + self.config["name"] + ".tar.gz",
            ".tar.gz":          self.config["output"] + "/" + self.config["name"] + ".tar.xz",
            ".plasmoid":        self.config["output"] + "/" + self.config["name"] + ".plasmoid",
            "outputDir":        self.config["output"] + "/",
            }

    def getInstalls(self):
        subdirs = [os.path.join(p, n) for p,s,f in os.walk(self.config["name"]) for n in s]
        files   = [os.path.join(p, n) for p,s,f in os.walk(self.config["name"]) for n in f]
        dirs    = []

        n = 0
        for d in [[(d in s) for s in subdirs].count(True) for d in subdirs]:
            if (d == 1):
                dirs.append(subdirs[n])
            n+=1

        data = "\n"
        for path in dirs:
            data += '    install -d "${pkgdir}"/usr/share/plasma/plasmoids/'
            data += '{path}\n'.format(path=path)
        data += "\n"
        for path in files:
            data += '    install -t "${pkgdir}"/usr/share/plasma/plasmoids/'
            data += '{path_dir}/ {path}\n'.format(path_dir=os.path.dirname(path), path=path)
        data += "}\n"
        return data
    def replaceAll(self, data):
        for key in self.replaceData:
            data = data.replace(key, str(self.replaceData[key]))
        return data

    def build(self):
        os.system("mkdir {}".format(self.pathsData["outputDir"]))
        os.system("cp -r {} {}".format(self.config["name"], self.pathsData["outputDir"]))
        os.system("cp -r {} {}".format("PKGBUILD",          self.pathsData["outputDir"]))

        # metadata.json
        with open(self.pathsData["metadata.json"], "r") as f:
            data = self.replaceAll(f.read())
        with open(self.pathsData["metadata.json"], "w") as f:
            f.write(data)
        # metadata.desktop
        with open(self.pathsData["metadata.desktop"], "r") as f:
            data = self.replaceAll(f.read())
        with open(self.pathsData["metadata.desktop"], "w") as f:
            f.write(data)
        os.system("(cd {} && tar czvf ../{} {})".format(self.pathsData["outputDir"], self.pathsData[".tar.gz"], self.config["name"]))
        os.system("cp {} {}".format(self.pathsData[".tar.gz"], self.pathsData[".plasmoid"]))
        # CHKSUM
        sha1 = hashlib.sha1()
        with open(self.pathsData[".plasmoid"], 'rb') as f:
            while True:
                data = f.read(self.BUF_SIZE)
                if not data:
                    break
                sha1.update(data)
        self.replaceData.update({"#CHKSUM#": sha1.hexdigest()})
        # PKGBUILD
        with open(self.pathsData["PKGBUILD"], "r") as f:
            data = self.replaceAll(f.read())
        with open(self.pathsData["PKGBUILD"], "w") as f:
            f.write(data)

app = Compiler()
app.build()
