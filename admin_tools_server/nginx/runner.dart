import "dart:io";
 void main(){
   //print(new File("nginx/nginxGUI.exe").existsSync());

   Directory.current = new Directory("nginx");
   
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
   String projectDirectory = "D:/Projekty/htdocs/gimme_admin_tools/admin_tools_server";
   Process.run("sudo",["nginx","-c","$projectDirectory/nginx/conf/nginx.conf","-p","$projectDirectory/"]);
//   Implement runner for Windows
//   Process.run("$projectDirectory/nginx/nginx.exe",["-c","$projectDirectory/nginx/conf/nginx.conf","-p","$projectDirectory/"]);

 }