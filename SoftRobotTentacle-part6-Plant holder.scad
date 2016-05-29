
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
bottomThickness=4;
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

//Plant part
plantHoleDiam=17;
plantScrewsDiam=3.5;

$fn=200;

translate ([0,0,-straightHeightBottom+(LDRHolderThickness-bottomThickness)])rotate(180, [1,0,0]) union() {

difference(){
//Main cylinder
translate([0,0,-bottomThickness]) cylinder(LDRHolderThickness,d2=plantHoleDiam-delta,d1=plantHoleDiam-delta);
translate([0,0,-bottomThickness+1]) cylinder(LDRHolderThickness+1,d2=plantHoleDiam-delta-2,d1=plantHoleDiam-delta-2);

//Hole for soil
//translate([0,0,1.2]) cylinder(LDRHolderThickness,d2=plantHoleDiam-1.2,d1=plantHoleDiam-1.2);

//Hole for wires
cylinder(bottomThickness*2,d2=3,d1=2);

}

/*    
//Cut holes for plant screws
translate([0,0,(LDRHolderThickness-bottomThickness)/2]) rotate(90, [0,1,0]) cylinder(LDRHolderThickness*100,d2=plantScrewsDiam-1,d1=plantScrewsDiam-1);
rotate (120) translate([0,0,(LDRHolderThickness-bottomThickness)/2]) rotate(90, [0,1,0]) cylinder(LDRHolderThickness*100,d2=plantScrewsDiam-1,d1=plantScrewsDiam-1);
rotate (240) translate([0,0,(LDRHolderThickness-bottomThickness)/2]) rotate(90, [0,1,0]) cylinder(LDRHolderThickness*100,d2=plantScrewsDiam-1,d1=plantScrewsDiam-1);
*/

//Top cone-like part
difference() {
translate([0,0,(LDRHolderThickness-bottomThickness)]) cylinder(LDRHolderThickness/2,d1=plantHoleDiam-delta,d2=(2/3)*(plantHoleDiam-delta));
translate([0,0,(LDRHolderThickness-bottomThickness)]) cylinder(LDRHolderThickness/2,d1=plantHoleDiam-delta-2,d2=(2/3)*(plantHoleDiam-delta)-2);
}
}