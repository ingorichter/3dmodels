spacerHeight = 6.8;
spacerDepth = 8; // really the thickness
spacerLength = 96;

backBracketHeight = 20;

module easel_Spacer(height, length, depth) {
    module base (width, height) {
        kerbeRadius = 1.5;
        $fn = 90;
        
        color("LightSkyBlue")
        difference() {
            cube([width, depth, height]);
            rotate([90, 0, 0]) {
                translate([length, 4, -depth]) {
                    cylinder(h=depth, r=kerbeRadius, center=false);
                }
            }
        }
    }
    
    module frontStopper(width, height) {
        noseWidth = 3.45;
        noseHeight = 4;
        noseOffset = 2.5;
        
        translate([60, 0, 0]) {
            color("red")
            cube([width, depth, height + noseHeight]);

            union() {
                translate([-noseWidth + noseOffset, 0, height]) {
                    color("blue")
                    cube([noseWidth, depth, noseHeight]);
                }
                
                $fn = 90; // make it 90 vertices
                radius = (noseHeight / 2);
                rotate([90, 0, 0]) {
                    translate([-noseWidth + noseOffset, height + noseHeight - radius, -depth]) {
                        color("orange")
                        cylinder(h=depth, r=radius, center=false);
                    }
                }
            }
        }
    }

    module backStopper(width, height) {
        color("Purple")
        
        translate([-width, 0, 0]) {
            cube([width, depth, height]);
        }
    }

    union() {
        frontStopperWidth = 5;
        frontStopperHeight = 19;
        backStopperWidth = 5;
        backStopperHeight = 23;

        base(length, height);
        frontStopper(frontStopperWidth, frontStopperHeight);
        backStopper(backStopperWidth, backStopperHeight);
    }
}

easel_Spacer(spacerHeight, spacerLength, spacerDepth);