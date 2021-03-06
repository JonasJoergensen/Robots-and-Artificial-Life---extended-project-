
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

union() {


//Main cone
difference(){

union() {
cylinder(h*(3/4)+FinalBottomThickness,d2=maxDiam+moldWallThickness*4,d1=maxDiam+moldWallThickness*4); //Solid cylinder
translate([(maxDiam+moldWallThickness*4)/3,-supportMoldWidth/2,0]) cube([supportMoldLength,supportMoldWidth,finMoldHeight+FinalBottomThickness]);//Solid cube 1
rotate (120) translate([(maxDiam+moldWallThickness*4)/3,-supportMoldWidth/2,0]) cube([supportMoldLength,supportMoldWidth,finMoldHeight+FinalBottomThickness]);//Solid cube 2
rotate (240) translate([(maxDiam+moldWallThickness*4)/3,-supportMoldWidth/2,0]) cube([supportMoldLength,supportMoldWidth,finMoldHeight+FinalBottomThickness]);//Solid cube 3

    }
    
translate([0,0,FinalBottomThickness]) {
    translate([(maxDiam+moldWallThickness*4)/3+moldWallThickness,-supportMoldWidth/2+moldWallThickness,0]) cube([supportMoldLength-moldWallThickness*2,supportMoldWidth-moldWallThickness*2,h+FinalBottomThickness]); //Erase cube 1
    
rotate (120) translate([(maxDiam+moldWallThickness*4)/3+moldWallThickness,-supportMoldWidth/2+moldWallThickness,0]) cube([supportMoldLength-moldWallThickness*2,supportMoldWidth-moldWallThickness*2,h+FinalBottomThickness]); //Erase cube 2

rotate (240) translate([(maxDiam+moldWallThickness*4)/3+moldWallThickness,-supportMoldWidth/2+moldWallThickness,0]) cube([supportMoldLength-moldWallThickness*2,supportMoldWidth-moldWallThickness*2,h+FinalBottomThickness]); //Erase cube 3


cylinder(h+FinalBottomThickness,d2=maxDiam+moldWallThickness*2,d1=maxDiam+moldWallThickness*2); //Erase cylinder


}
cylinder(FinalBottomThickness,d1=wiresDiameter,d2=wiresDiameter); //Make hole for wires

rotate(270, [0,1,0]) cylinder(finMoldWidth,d1=wiresDiameter,d2=wiresDiameter); //Make SLIT for wires

}



}
