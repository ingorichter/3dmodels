// Base for https://home.lamarzoccousa.com/product/artpresso-primo-distribution-tool/

// some parameters to adjust the design
diameter = 59; //mm diameter of distribution tool is 58.3mm
wallThickness = 4; //mm thickness of circle wall
maxHeight = 13; // mm max height of distribution tool
baseHeight = 10; // mm height of base 
baseWidth = 75; // mm width of base
baseLength = 75; // mm length of base

// Text
coffeeShopName = "Pampas Cafe";
copyrightName = "© Ingo";

// place the base and substract the copyright notice to create the emboss effect
difference() {
    RoundedCornerSquareBase();
    CopyrightNotice();
}

// place the cylinger on top of the base
HollowCylinder();

$fn=150; // segments per 360 degrees of cylinder

module RoundedCornerSquareBase() {
    minkowski() {
        // the square base
        translate([0, 0, baseHeight / 2]) {
            color("blue")
            cube([baseWidth, baseLength, baseHeight], center=true);
        }

        // create rounded corners
        cylinder(r=5, h=1);
    }

    CoffeeShopName();
}

module HollowCylinder() {
    translate([0, 0, baseHeight]) {
        difference() {
            cylinder(h=maxHeight, d=diameter + wallThickness);
            cylinder(h=maxHeight, d=diameter);
        }
    };
}

module CopyrightNotice() {
    mirror([0, 180, 0]) {
        rotate([90, 0, 180]) {
            translate([0, 3, -44]) {
                linear_extrude(2) {
                    text(copyrightName, size=6, halign="center");
                }
            }
        }   
    }
}

module CoffeeShopName() {
    // place coffee shop name on top of base
    translate([0, -39, baseHeight + 1]) {
        linear_extrude(0.5) {
            text(coffeeShopName, font="Gill Sans:style=Bold", size=9, halign="center");
        }
    }
}