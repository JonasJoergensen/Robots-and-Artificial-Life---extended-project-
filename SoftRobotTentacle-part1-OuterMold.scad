
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

difference(){

union() {

difference(){

//Top part
translate ([0,0,h-3]) cylinder(straightHeight+3,d2=maxDiam+6+moldWallThickness*2+delta,d1=maxDiam+6+moldWallThickness*2+delta);
translate ([0,0,h]) cylinder(straightHeight,d2=maxDiam+6,d1=maxDiam+6);
cylinder(h,d2=maxDiam,d1=minDiam);

}

//Main cone
difference(){
cylinder(h,d2=maxDiam+6+moldWallThickness*2,d1=minDiam+moldWallThickness*2);
cylinder(h,d2=maxDiam,d1=minDiam);

}

//Straight bottom part
translate ([0,0,-straightHeightBottom]) difference(){
cylinder(straightHeightBottom,d2=minDiam+moldWallThickness*2,d1=minDiam+moldWallThickness*2);
cylinder(straightHeightBottom,d2=minDiam,d1=minDiam);

}


//Bottom and foot
translate ([0,0,-straightHeightBottom-bottomThickness]) cylinder(bottomThickness,d2=footDiam,d1=footDiam);


////Screw holders at 1st side////

translate([0,-moldWallThickness,0]){

//Holes    
difference(){
translate ([(minDiam+maxDiam)/4-moldWallThickness,0,-straightHeightBottom-bottomThickness]) cube([assemblyWidth,moldWallThickness*2,h+straightHeightBottom+bottomThickness+straightHeight]); //Long plate
   
d=(h+straightHeightBottom+bottomThickness+straightHeight-40)/numberOfHoles; //Distance between holes

for(k = [0:numberOfHoles]){
rotate(90, [1, 0, 0]) translate ([(minDiam+maxDiam)/4-moldWallThickness+12+4.5*(k/numberOfHoles),-straightHeightBottom+20+(k)*d,-moldWallThickness]) 
cylinder(moldWallThickness*2,d2=screwSize,d1=screwSize);
}

cylinder(h,d2=maxDiam,d1=minDiam); //Remove inner parts of cone again
translate ([0,0,h]) cylinder(straightHeight,d2=maxDiam+6,d1=maxDiam+6); //Remove inner parts of top again
translate ([0,0,-straightHeightBottom]) cylinder(straightHeightBottom,d2=minDiam,d1=minDiam);//Remove inner parts of bottom again
}

}

////Screw holders at 2nd side////

rotate(180, [0,0,1]){
    
//Holes    
difference(){
translate ([(minDiam+maxDiam)/4-moldWallThickness,-moldWallThickness,-straightHeightBottom-bottomThickness]) cube([assemblyWidth,moldWallThickness*2,h+straightHeightBottom+bottomThickness+straightHeight]); //Long plate
   
d=(h+straightHeightBottom+bottomThickness+straightHeight-40)/numberOfHoles; //Distance between holes

for(k = [0:numberOfHoles]){
rotate(90, [1, 0, 0]) translate ([(minDiam+maxDiam)/4-moldWallThickness+12+4.5*(k/numberOfHoles),-straightHeightBottom+20+(k)*d,-moldWallThickness]) 
cylinder(moldWallThickness,d2=screwSize,d1=screwSize);
}

cylinder(h,d2=maxDiam,d1=minDiam); //Remove inner parts of cone again
translate ([0,0,h]) cylinder(straightHeight,d2=maxDiam+6,d1=maxDiam+6); //Remove inner parts of top again
translate ([0,0,-straightHeightBottom]) cylinder(straightHeightBottom,d2=minDiam,d1=minDiam);//Remove inner parts of bottom again

}

}

}

translate ([-footDiam/2,0,-straightHeightBottom-bottomThickness]) cube([footDiam,footDiam,h+straightHeight+straightHeightBottom+bottomThickness]); //Cut half off the mold

//Make cutout at bottom for LDR holder
translate ([0,0,-straightHeightBottom]) cylinder(LDRHolderThickness+delta,d2=LDRHolderDiam+delta,d1=LDRHolderDiam+delta);

}
