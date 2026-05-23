$fs=0.1;
$fa=1;

wrist_width = 200;
wrist_height = 100;
fist_radius = 200;
cuff_length = 40;
shell_thickness = 5;

module ball() {
    difference(){
        sphere(r=fist_radius+shell_thickness);
        sphere(r=fist_radius);
    }
}

module wrist_blank(extme=cuff_length) {
    rotate([90,0,0])
    linear_extrude(extme)
    union() {
        square([wrist_width-wrist_height, wrist_height+2*shell_thickness], center=true);
        translate([(wrist_width-wrist_height)/2,0])
            circle(r=(wrist_height+2*shell_thickness)/2);    
        translate([-(wrist_width-wrist_height)/2,0])
            circle(r=(wrist_height+2*shell_thickness)/2);    
    }
}

module wrist_hole() {
    translate([0,1,0])
    rotate([90,0,0])
    linear_extrude(cuff_length+2)
    union() {
        square([wrist_width-wrist_height, wrist_height], center=true);
        translate([(wrist_width-wrist_height)/2,0])
            circle(r=wrist_height/2);    
        translate([-(wrist_width-wrist_height)/2,0])
            circle(r=wrist_height/2);    
    }
}

module wrist() {
    difference() {
        wrist_blank();
        wrist_hole();
    }
}

module cut_ball() {
    difference() {
        ball();
        translate([0,-fist_radius+cuff_length,0])
            wrist_blank(extme=100);
    }
}

module full_hand() {
    translate([0,-fist_radius+cuff_length,0])
        wrist();
    cut_ball();
}

module latch() {
    cylinder(r=20, h=20, center=true);
    translate([0,0,15])
    cylinder(r=30, h=20, center=true);
}

module hand_with_latches() {
    full_hand();
    
    for (i = [-45:45:225]){
        translate([(fist_radius+10)*cos(i),(fist_radius+10)*sin(i),0])
        rotate([0,90,i])
        latch();           
    }
    
}

module half_slice() {
    size=1000;
    difference() {
        hand_with_latches();
        translate([-size/2,-size/2,-size])
        cube([size,size,size]);
    }
}

half_slice();