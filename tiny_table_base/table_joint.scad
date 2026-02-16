
$fa = 1;
$fs = 0.1;

dowel_radius=20;
panel_radius=40;
wall_thickness=5;
panel_thickness=5;
num_holes=8;
fitting_depth=20;
hole_radius=2;
hole_inset_dist=5;

module pipe_fitting(){
    difference() {
        cylinder(h=fitting_depth, r=dowel_radius+wall_thickness);
        translate([0,0,-1])
        cylinder(h=fitting_depth+2, r=dowel_radius);
    }
}

module panel() {
    difference() {
        cylinder(h=panel_thickness,r=panel_radius);
        for (i=[0:360/num_holes:359]) {
            translate([(panel_radius-hole_inset_dist)*cos(i), (panel_radius-hole_inset_dist)*sin(i), -1])
            cylinder(h=panel_thickness+2,r=hole_radius);
        }
        translate([0,0,0.5])
        cylinder(h=fitting_depth+2, r=dowel_radius);
    }
}

module table_joint(){
    panel();
    translate([0,0,panel_thickness-0.001])
    pipe_fitting();
}

table_joint();
//panel();
