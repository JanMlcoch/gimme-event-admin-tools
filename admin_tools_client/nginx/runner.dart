import 'dart:async';
import 'dart:convert';
import "dart:io";
import 'package:path/path.dart' as path_lib;

Directory project;
Directory web;
Directory nginx;

 void main(){
   project = new Directory(getProjectDirectoryName());

   Directory.current = project;
   nginx = new Directory("nginx");
   web = new Directory("web");
   Directory.current = nginx;

   Directory logs = new Directory("logs");
   File accessLog = new File("logs/access.log");
   File errorLog = new File("logs/error.log");
   if(!logs.existsSync()){
     logs.createSync();
     accessLog.createSync();
     errorLog.createSync();
   } else {
     if(accessLog.existsSync() && !errorLog.existsSync())
       errorLog.createSync();
     else if(!accessLog.existsSync() && errorLog.existsSync())
       accessLog.createSync();
     else{
       accessLog.createSync();
       errorLog.createSync();
     }
   }

   print(Directory.current.path);

//   String projectDirectory = "/home/hosekp/htdocs/aqueduct2";
//
   if(Platform.isLinux){
     Process.run("sudo",["nginx","-c","${project.path}/nginx/conf/nginx.conf","-p","${project.path}/nginx/"]);
   }else{
     Process.start("nginx.exe",["-c","${project.path}/nginx/conf/nginx.conf","-p","${project.path}/nginx/"]).then((Process process) {
       printFromOutputStreams(process, "Nginx");
     });;
   }


//   Directory.current = new Directory("../");
//   projectDirectory = Directory.current.path.toString();
//
////   Process.run("sudo",["nginx","-c","$projectDirectory/nginx/conf/nginx.conf","-p","$projectDirectory/"]);
////   Implement runner for Windows
//   Process.run("$projectDirectory/nginx/nginx.exe",["-c","$projectDirectory/nginx/conf/nginx.conf","-p","$projectDirectory/"]);

 }


String getProjectDirectoryName() {
  Directory projectDir = Directory.current;
  int overflowProtection =0;
  while(!isFileInFileSystemEntityList(projectDir.listSync(followLinks: false),"pubspec.yaml")){
    if(overflowProtection++>30){
      throw new Exception("Cannot found project dir");
    }
    projectDir = projectDir.parent;
  }
  return projectDir.path;
}

bool isFileInFileSystemEntityList(List<FileSystemEntity> list, String filename){
  for(FileSystemEntity f in list){
    if(path_lib.basename(f.path)==filename){
      return true;
    }
  }
  return false;
}


void printFromOutputStreams(Object process, [String prefix = ""]) {
  Stream<List<int>> stdout;
  Stream<List<int>> stderr;
  if (process is Process) {
    stdout = process.stdout;
    stderr = process.stderr;
    stderr.transform(UTF8.decoder).listen((String data) {
      print("error$prefix: $data");
    });
    stdout.transform(UTF8.decoder).listen((String data) {
      print("out$prefix: $data");
    });
  } else if (process is ProcessResult) {
    if (process.stdout is String) {
      if (process.stdout != "")
        print("out$prefix: ${process.stdout}");
    } else {
      print("out$prefix: ${new String.fromCharCodes(process.stdout)}");
    }
    if (process.stderr is String) {
      if (process.stderr != "")
        print("err$prefix: ${process.stderr}");
    } else {
      print("err$prefix: ${new String.fromCharCodes(process.stderr)}");
    }
  } else {
    throw new ArgumentError("unknown type - cannot extract stdout and stderr");
  }
}