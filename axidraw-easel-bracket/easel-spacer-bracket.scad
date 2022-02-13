spacerThickness = 8;
frontSpacerHeight = 12;

module easel_Spacer(spacerThickness, frontSpacerHeight) {
    module frontSpacerBase (width, height, offsetFromBackStopper) {
        notchRadius = 2;
        notchDiameter = notchRadius * 2;
        notchCenterDistanceFromBottom = 5; // this fits underneath the easel
        legLength = 5; // length of legs under and over the easel surface
        $fn = 90;
        
        translate([offsetFromBackStopper, 0, 0]) {
            color("LightSkyBlue")
            difference() {
                cube([width, spacerThickness, height]);
                rotate([90, 0, 0]) {
                    translate([width, notchCenterDistanceFromBottom + notchRadius, -spacerThickness]) {
                        cylinder(h=spacerThickness, r=notchRadius, center=false);
                    }
                }
            }

            // legs
            color("Orange")
            translate([width, 0, 0]) {
                cube([legLength, spacerThickness, notchCenterDistanceFromBottom]);
            }
            translate([width, 0, notchCenterDistanceFromBottom + notchDiameter]) {
                cube([legLength, spacerThickness, height - notchCenterDistanceFromBottom - notchDiameter]);
            }
        }
    }
    
    module backSpacerBase(width, height) {
        color("gold")
        cube([width, spacerThickness, height]);
    }
    
    module frontStopper(width, height, frontstopperDistanceFromBackStopper) {
        noseWidth = 3.45;
        noseHeight = 4;
        noseOffset = 2.5;
        
        translate([frontstopperDistanceFromBackStopper, 0, 0]) {
            color("red")
            cube([width, spacerThickness, height + noseHeight]);

            union() {
                translate([-noseWidth + noseOffset, 0, height]) {
                    color("blue")
                    cube([noseWidth, spacerThickness, noseHeight]);
                }
                
                $fn = 90; // make it 90 vertices
                radius = (noseHeight / 2);
                rotate([90, 0, 0]) {
                    translate([-noseWidth + noseOffset, height + noseHeight - radius, -spacerThickness]) {
                        color("orange")
                        cylinder(h=spacerThickness, r=radius, center=false);
                    }
                }
            }
        }
    }

    module backStopper(width, height) {
        color("Purple")
        
        translate([-width, 0, 0]) {
            cube([width, spacerThickness, height]);
        }
    }

    // put everything together
    union() {
        wholeSpacerLength = 96; // that's the optimal length. Don't change
        backSpacerHeight = 6.8; // height of plotter. Don't change

        frontStopperWidth = 5;
        frontStopperHeight = 19;
        backStopperWidth = 5;
        backStopperHeight = 23;
        frontstopperDistanceFromBackStopper = 60; // this is the width of the plotter

        backSpacerBase(frontstopperDistanceFromBackStopper, backSpacerHeight);
        frontSpacerBase(wholeSpacerLength - frontstopperDistanceFromBackStopper + frontStopperWidth, frontSpacerHeight, frontstopperDistanceFromBackStopper + frontStopperWidth);
        backStopper(backStopperWidth, backStopperHeight);
        frontStopper(frontStopperWidth, frontStopperHeight, frontstopperDistanceFromBackStopper);
    }
}

easel_Spacer(spacerThickness, frontSpacerHeight);