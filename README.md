# assembly_programs
Assembly programs:

Compiled using Visual Studios:
Download Irvine.Inc library: http://asmirvine.com/

Create MASM environment in VS2019:
1. Create C++ empty project 
2. Right click on Project --> 
	--> "Build Dependecies"
	--> "Build customizations"
	--> Click "masm(targets...)"
	Hit OK
3. Right click on Project -->
	--> "Configuration Properties"
	--> Linker->Systems
	--> Select "SubSystem" --> "Windows (/SUBSYSTEM:WINDOWS)"
4. Right click on Project -->
	--> Hit "Add" --> new C++ file
	--> Name file "main.asm"
 
To save project as environment in VS2019
See "main.asm" to add to file
5. Go to "Projects" 
  --> "Export Template"
  --> Change "Template name" to MASM
  --> Leave defaults and hit finish
--> Add any of the .asm programs and run
