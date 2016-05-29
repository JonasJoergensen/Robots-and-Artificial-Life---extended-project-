//Sheat
sheatThickness = 1.6;


//Main cone and mold
h = 180; //Cone height
maxDiam = 45; //Cone
minDiam = 35; //Cone
centerSolidDiam=15;
moldWallThickness = 3;
footDiam=100; //Foot for mold
siliconeThickness=3; //Outer
dividersThickness = 5;
////Assembly on the sides of mold////
numberOfHoles = 4;
screwSize=5;
assemblyWidth= 22;

//Bottom
straightHeightBottom = 20;
bottomThickness=3.5;
LDRHolderThickness= 10;
LDRHolderDiam= minDiam+3;
delta=0.4; //Inaccuracy of printer (layering and overextrusion)
LDRHoleDepth=8;//NOT MEASURED
LDRHolderThickness = 8 +2.5;
LDRDiam=6; //NOT MEASURED
LDRWireHolesDist=3;//NOT MEASURED distance between wires on LDR
LDRHoleDist=LDRHolderDiam/2-LDRDiam;
LDRNumber=3;

//Top part
straightHeight= 30; 
wiresDiameter=5; 

//Joints
jointThickness = 3;

//Assembly
numberOfHoles = 4;
screwSize=5;


//Finishing mold:
finMoldHeight=25;
finMoldWidth=30;
supportMoldLength=60;
supportMoldWidth=30;
FinalBottomThickness =8;

$fn=200;

//Main cone
difference(){
cylinder(h,d2=maxDiam+sheatThickness*2,d1=minDiam+sheatThickness*2);
cylinder(h,d2=maxDiam,d1=minDiam);

}