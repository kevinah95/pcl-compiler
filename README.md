# pcl-compiler

This compiler is based on a made-up language called PCL.

## Building PCL Compiler

### Prerequisites
To build PCL Compiler you'll need: 
- Install Java 8
  - On Windows and Linux, install the latest [JRE 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html) from Oracle.
  - On Mac OS X, download and install [JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html).
- Install [Apache Ant](http://ant.apache.org/bindownload.cgi), using their instructions and one of their Binary Distribution.
  - Ant 1.9 or later is required.
- Clone the source repository from Github.
 - On the command line, enter:
```batch
$ git clone https://github.com/kevinah95/pcl-compiler.git
```
- Open a terminal/console/command prompt, change to the directory where you cloned pcl-compiler, and type:
```batch
$ cd src/com/pcl/lexer/
$ ant run
```
### That didn't work
No problem, here are more details for what may have gone wrong:
- *Make sure that `java` is available.* From any terminal/console/command prompt, and type `java` and see what happens. If it says something like `command not found`, then it may be the case that
 - Java may not be installed (did you _really_ skip the first line of the instructions above?)
 - The wrong version of Java is installed (32-bit instead of 64-bit, or vice-versa)
 - The `java` command is [not in your system's PATH](http://www.java.com/en/download/help/path.xml). 
 - Computers don't like you.

- *Make sure that `ant` is available.* Do the same steps as with `java`, above. 

## Contributing
See our [CONTRIBUTING.md](CONTRIBUTING.md) page for details. Bugs can be reported here on Github.
## License
PCL Compiler is licensed to the public under the terms of the MIT License. Alternate licensing options are available. For complete licensing information, see the [LICENSE](LICENSE) file in this repository.
