$fn = 32;
//unit = mm
boardTolerance = 0.5;
boardX = 59.69 + boardTolerance;
boardY = 85.09 + boardTolerance;
boardZ = 1.6;
overhang = 3;
delta = 0.02;
floorThickness = 2;
xExtraSpace = 10;
buttonToUserPannel = 12; //distance between top of board to top of gehaeuse
deckelDicke = 4;
wallUpper = deckelDicke;
//clearence = 30;
clearence = 25;

mountingPillarThickness = 6;
mountingNutDiameter = 4;
mountingNutScrewDiameter = 3;
renderMode = 1; //1 = 3D lower, 2 = 2D upper, 3 = 2D upper outline, 4 = 2D upper text
//color([0,1,0]) cube([boardX-delta, boardY-delta, boardZ-delta]);

tolerance = 0; //faster rendering
//tolerance = 2; //simpler testing
//tolerance = 0.3; //for final render

usbHoleThickness = 10;
usbHoleLength = 12;

mountingScrewDiameter = 6;
mountingScewHeadDiameter = 10;

module usbHole() {
    hull() {
        translate([-usbHoleLength/2,0,0]) cylinder(h=wallUpper+overhang+2*delta, d=usbHoleThickness);
        translate([+usbHoleLength/2,0,0]) cylinder(h=wallUpper+overhang+2*delta, d=usbHoleThickness);
    }
}

module mountingScrewHole() {
    hull() {
        translate([0,+mountingScewHeadDiameter/2,0]) cylinder(h=floorThickness+2*delta, d=mountingScrewDiameter);
        translate([0,-mountingScewHeadDiameter/2,0]) cylinder(h=floorThickness+2*delta, d=mountingScrewDiameter);
    }
    translate([0,-mountingScewHeadDiameter/2,0]) cylinder(h=floorThickness+2*delta, d=mountingScewHeadDiameter);
}

module mountingPiller(x,y) {
    translate([x,y,-clearence]) cylinder(h=clearence+delta, r=mountingPillarThickness);
    //translate([x,y,0]) cylinder(h=boardZ+2*delta, r=mountingHoleSize);
}

module mountingHole(x,y) {
    depth = 10;
    translate([x,y,-depth]) cylinder(h=depth+2*delta, d=mountingNutDiameter);
}
module upperPart() {   
    keyHoleSize = 19;
    textOffsetX = keyHoleSize/2 + 2;
    textOffsetY = 10/2;
    edgePatternSize = 10;
    if(renderMode != 4) {
    difference() {    
        color([0,1,0]) translate([-wallUpper-delta, -wallUpper-delta]) square(size = [boardX+2*wallUpper+xExtraSpace+2*delta, boardY+2*wallUpper+2*delta]);
        translate([17.78,12.70]) square(size = [keyHoleSize,keyHoleSize], center=true);
        translate([17.78,33.02]) square(size = [keyHoleSize,keyHoleSize], center=true);
        translate([17.78,53.34]) square(size = [keyHoleSize,keyHoleSize], center=true);
        translate([17.78,73.66]) square(size = [keyHoleSize,keyHoleSize], center=true);
        
        if(renderMode != 1) {
          translate([boardX+xExtraSpace/2, boardY-xExtraSpace/2]) circle(d=mountingNutScrewDiameter);
           translate([boardX+xExtraSpace/2, xExtraSpace/2]) circle(d=mountingNutScrewDiameter);
           translate([5.08+(boardTolerance/2), 40.64+(boardTolerance/2)]) circle(d=mountingNutScrewDiameter);
        }
        
        for(i = [1 : 2 : 8]) {
            translate([-wallUpper-delta, -wallUpper+i*edgePatternSize]) square(size = [deckelDicke+delta+tolerance,  edgePatternSize]);
            translate([boardX+xExtraSpace+2*delta-tolerance, -wallUpper+i*edgePatternSize]) square(size = [deckelDicke+delta+tolerance,  edgePatternSize]);
        }
        i = 1;
        for(i = [1.5 : 2 : 7]) {
          translate([-wallUpper-delta+i*edgePatternSize, -wallUpper-2*delta]) square(size = [edgePatternSize, deckelDicke+delta+tolerance]);
          translate([-wallUpper-delta+i*edgePatternSize, boardY+2*delta-tolerance]) square(size = [edgePatternSize, deckelDicke+delta+tolerance]);
        }
    }}
    if(renderMode != 3) {
      color([1,0,0]) translate([17.78+textOffsetX,12.70-textOffsetY]) text("Deko");
      color([1,0,0]) translate([17.78+textOffsetX,73.66-textOffsetY]) text("On");
      color([1,0,0]) translate([17.78+textOffsetX,53.34-textOffsetY]) text("Abort");
      color([1,0,0]) translate([17.78+textOffsetX,33.02-textOffsetY]) text("Off");
    }
}
/* //Prototype: Mounting Pillar
difference() {
mountingPiller(0,0);
translate([-20, -20, -52]) cube([50,50,50]);
mountingHole(0,0, "M3");
}
difference() {
mountingPiller(10,0);
translate([-20, -20, -52]) cube([50,50,50]);
mountingHole(10,0, "M4");
}
difference() {
mountingPiller(20,0);
translate([-20, -20, -52]) cube([50,50,50]);
mountingHole(20,0, "M5");
}
difference() {
mountingPiller(30,0);
translate([-20, -20, -52]) cube([60,60,50]);
mountingHole(30,0, "M6");
}*/

if(renderMode == 1) {
difference() {
union() {
difference() {
    mainCubeSizeX = boardX+2*wallUpper+xExtraSpace;
    mainCubeSizeY = boardY+2*wallUpper;
    mainCubeSizeZ = clearence+boardZ+floorThickness+buttonToUserPannel;
    
    translate([-wallUpper, -wallUpper, -clearence-floorThickness]) cube([mainCubeSizeX, mainCubeSizeY, mainCubeSizeZ]);
    translate([0, 0, 0]) cube([boardX, boardY, boardZ+delta+buttonToUserPannel]);
    translate([overhang, overhang, -clearence]) cube([boardX-1*overhang, boardY-2*overhang, clearence+boardZ]);
    translate([0,0, boardZ]) 
    difference() {
        cube([boardX+xExtraSpace-delta, boardY, buttonToUserPannel+2*delta]);
        translate([boardX-delta,-delta,0]) cube([xExtraSpace, xExtraSpace, buttonToUserPannel+3*delta]);
       translate([boardX-delta,boardY-xExtraSpace,0]) cube([xExtraSpace, xExtraSpace, buttonToUserPannel+3*delta]);
    }
    translate([0,0, buttonToUserPannel]) mountingHole(boardX+xExtraSpace/2,boardY-xExtraSpace/2);
    translate([0,0, buttonToUserPannel]) mountingHole(boardX+xExtraSpace/2,xExtraSpace/2);
    translate([0,0, boardZ + buttonToUserPannel - deckelDicke + delta]) minkowski(){
       linear_extrude(height = deckelDicke+delta) upperPart();
       sphere(tolerance);
    }
};

mountingPiller(5.08+(boardTolerance/2),20.32+(boardTolerance/2));

mountingPiller(5.08+(boardTolerance/2),40.64+(boardTolerance/2));
//mountingHole(5.08,40.64);
//mountingHole(5.08,58.42);
mountingPiller(5.08+(boardTolerance/2),78.74+(boardTolerance/2));
mountingPiller(52.07+(boardTolerance/2),7.62+(boardTolerance/2));
difference() {
    union() {
        mountingPiller(52.07+(boardTolerance/2),78.74+(boardTolerance/2));
        translate([52.07+(boardTolerance/2),78.74+(boardTolerance/2)-mountingPillarThickness,-clearence]) cube([mountingPillarThickness+4,2*mountingPillarThickness,clearence]);
    }
    translate([52.07+(boardTolerance/2),78.74+(boardTolerance/2)-10,-28]) rotate([45,0,0]) translate([-10,0,-100]) cube([20,20,200]);
}
}

mountingHole(5.08+(boardTolerance/2),20.32+(boardTolerance/2));
mountingHole(5.08+(boardTolerance/2),40.64+(boardTolerance/2));
mountingHole(5.08+(boardTolerance/2),78.74+(boardTolerance/2));
mountingHole(52.07+(boardTolerance/2),7.62+(boardTolerance/2));
mountingHole(52.07+(boardTolerance/2),78.74+(boardTolerance/2));

translate([boardX/2,boardY+wallUpper+delta,-13]) rotate([90,90,0]) usbHole();

translate([boardX/4, 3*boardY/4,-clearence-floorThickness-delta]) mountingScrewHole();
translate([3*boardX/4, 3*boardY/4,-clearence-floorThickness-delta]) mountingScrewHole();

//Prototype: deckel
//translate([-500,-500,-995]) cube([1000, 1000, 1000]);

//Prototype: Mounting the Board
//*
//translate([-500,-500,2*boardZ]) cube([1000, 1000, 1000]);
//translate([-500,-500,-1000-boardZ]) cube([1000, 1000, 1000]); /* */
};


} else {
    upperPart();
}

