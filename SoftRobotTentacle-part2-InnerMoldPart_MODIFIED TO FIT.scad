
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

union(){


//Three cone parts
difference(){
cylinder(h,d2=maxDiam-siliconeThickness*2,d1=minDiam-siliconeThickness*2);
cylinder(h,d2=centerSolidDiam,d1=centerSolidDiam);
    
translate ([0,-dividersThickness/2,0]) cube([maxDiam, dividersThickness,h], center=[0,0,0]);
rotate (120) translate ([0,-dividersThickness/2,0]) cube([maxDiam, dividersThickness,h], center=[0,0,0]);
rotate (240) translate ([0,-dividersThickness/2,0]) cube([maxDiam, dividersThickness,h], center=[0,0,0]);
}

//Top part
difference(){
translate ([0,0,h]) cylinder(straightHeight,d2=maxDiam+6-1,d1=maxDiam+6-1); //MODIFIED: Added -1
translate ([0,0,h]) cylinder(straightHeight,d2=centerSolidDiam+16,d1=centerSolidDiam);
}

//Wire attachment
difference(){
translate ([0,0,h+straightHeight-(5/2)]) cube ([maxDiam+6-2, 8, 5], center=true);
translate ([0,0,h+straightHeight-5]) cylinder(5,d2=wiresDiameter,d1=wiresDiameter);
}

}
