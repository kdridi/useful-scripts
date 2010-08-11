#!/bin/sh

DEBUG=0

showpatch() {
cat << "EOF"
Index: native-maven-plugin/src/test/java/org/codehaus/mojo/natives/plugin/NativeInitializeMojoTest.java
===================================================================
--- native-maven-plugin/src/test/java/org/codehaus/mojo/natives/plugin/NativeInitializeMojoTest.java	(revision 12433)
+++ native-maven-plugin/src/test/java/org/codehaus/mojo/natives/plugin/NativeInitializeMojoTest.java	(working copy)
@@ -29,7 +29,7 @@
         
         mojo.execute();
         
-        assertEquals( "someArtifactId", mojo.project.getBuild().getFinalName() );
+//        assertEquals( "someArtifactId", mojo.project.getBuild().getFinalName() );
     }
 
 }
Index: native-maven-plugin/src/main/java/org/codehaus/mojo/natives/plugin/NativeInitializeMojo.java
===================================================================
--- native-maven-plugin/src/main/java/org/codehaus/mojo/natives/plugin/NativeInitializeMojo.java	(revision 12433)
+++ native-maven-plugin/src/main/java/org/codehaus/mojo/natives/plugin/NativeInitializeMojo.java	(working copy)
@@ -57,14 +57,6 @@
         {
             buildDirectory.mkdirs();
         }
-        
-        //strip version from finalName since  and
-        // disallow user from changing the final name since many
-        //  final linker output depending heavily on the name without any associated version
-        String finalName = project.getArtifactId();
-        
-        project.getBuild().setFinalName( finalName );
-                
     }
 
 }
Index: native-maven-plugin/src/it/jni/pom.xml
===================================================================
--- native-maven-plugin/src/it/jni/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/jni/pom.xml	(working copy)
@@ -26,7 +26,7 @@
         <plugin>
           <groupId>org.codehaus.mojo</groupId>
           <artifactId>native-maven-plugin</artifactId>
-          <version>1.0-alpha-5-SNAPSHOT</version>
+          <version>1.0-alpha-5</version>
         </plugin>
       </plugins>
     </pluginManagement>
Index: native-maven-plugin/src/it/pom.xml
===================================================================
--- native-maven-plugin/src/it/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/pom.xml	(working copy)
@@ -20,7 +20,7 @@
         <plugin>
           <groupId>org.codehaus.mojo</groupId>
           <artifactId>native-maven-plugin</artifactId>
-          <version>1.0-alpha-5-SNAPSHOT</version>
+          <version>1.0-alpha-5</version>
         </plugin>
       </plugins>
     </pluginManagement>
Index: native-maven-plugin/src/it/linkages/linux-x86/ExeStatic/pom.xml
===================================================================
--- native-maven-plugin/src/it/linkages/linux-x86/ExeStatic/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/linkages/linux-x86/ExeStatic/pom.xml	(working copy)
@@ -43,6 +43,7 @@
   
   
   <build>
+    <finalName>ExeStatic</finalName>
     <plugins>
       <plugin>
         <groupId>org.codehaus.mojo</groupId>
Index: native-maven-plugin/src/it/linkages/linux-x86/libSubFuncDynamic/pom.xml
===================================================================
--- native-maven-plugin/src/it/linkages/linux-x86/libSubFuncDynamic/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/linkages/linux-x86/libSubFuncDynamic/pom.xml	(working copy)
@@ -16,6 +16,7 @@
   
   
   <build>
+    <finalName>libSubFuncDynamic</finalName>
     <plugins>
       <plugin>
         <groupId>org.codehaus.mojo</groupId>
Index: native-maven-plugin/src/it/linkages/linux-x86/libSubFuncStatic/pom.xml
===================================================================
--- native-maven-plugin/src/it/linkages/linux-x86/libSubFuncStatic/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/linkages/linux-x86/libSubFuncStatic/pom.xml	(working copy)
@@ -16,6 +16,7 @@
   
   
   <build>
+    <finalName>libSubFuncStatic</finalName>
     <plugins>
       <plugin>
         <groupId>org.codehaus.mojo</groupId>
Index: native-maven-plugin/src/it/linkages/linux-x86/libFuncDynamic/pom.xml
===================================================================
--- native-maven-plugin/src/it/linkages/linux-x86/libFuncDynamic/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/linkages/linux-x86/libFuncDynamic/pom.xml	(working copy)
@@ -26,6 +26,7 @@
   
   
   <build>
+    <finalName>libFuncDynamic</finalName>
     <plugins>
       <plugin>
         <groupId>org.codehaus.mojo</groupId>
Index: native-maven-plugin/src/it/linkages/linux-x86/libFuncStatic/pom.xml
===================================================================
--- native-maven-plugin/src/it/linkages/linux-x86/libFuncStatic/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/linkages/linux-x86/libFuncStatic/pom.xml	(working copy)
@@ -16,6 +16,7 @@
   
   
   <build>
+    <finalName>libFuncStatic</finalName>
     <plugins>
       <plugin>
         <groupId>org.codehaus.mojo</groupId>
Index: native-maven-plugin/src/it/linkages/linux-x86/ExeDynamic/pom.xml
===================================================================
--- native-maven-plugin/src/it/linkages/linux-x86/ExeDynamic/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/linkages/linux-x86/ExeDynamic/pom.xml	(working copy)
@@ -31,6 +31,7 @@
   
   
   <build>
+    <finalName>ExeDynamic</finalName>
     <plugins>
       <plugin>
         <groupId>org.codehaus.mojo</groupId>
Index: native-maven-plugin/src/it/linkages/pom.xml
===================================================================
--- native-maven-plugin/src/it/linkages/pom.xml	(revision 12433)
+++ native-maven-plugin/src/it/linkages/pom.xml	(working copy)
@@ -41,7 +41,6 @@
       <activation>
         <os>
           <family>Linux</family>
-          <arch>i386</arch>
         </os>
       </activation>
       <modules>
EOF
}


cd $(dirname $0)

rm -rf maven-native-1.0-alpha-5

if [ "${DEBUG}" -eq "1" ]
then
	tar xf maven-native-1.0-alpha-5.tar.bz2
else
	svn co http://svn.codehaus.org/mojo/tags/maven-native-1.0-alpha-5
fi

cd maven-native-1.0-alpha-5
showpatch | patch -p0

if [ ! -d "$1" ]
then
	exit 0
fi

rm -rf $1/org/codehaus/mojo/native*

mvn clean install

cd native-maven-plugin/src/it/linkages/

mvn package
ls --color=auto -l linux-x86/*/target