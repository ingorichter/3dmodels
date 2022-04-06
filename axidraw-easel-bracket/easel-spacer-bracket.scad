spacerThickness = 10;
frontSpacerHeight = 10;

module easel_Spacer(spacerThickness, frontSpacerHeight) {
    module frontSpacerBase (width, height, offsetFromBackStopper) {
        notchRadius = 1;
        notchDiameter = notchRadius * 2;
        notchCenterDistanceFromBottom = 4; // this fits underneath the easel
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
        noseHeight = 3.9;
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
        wholeSpacerLength = 88; // that's the optimal length. Don't change
        backSpacerHeight = 6.0; // height of plotter. Don't change

        frontStopperWidth = 5;
        frontStopperHeight = 18.8;
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