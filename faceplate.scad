font = "Tahoma";
letter_height = 5;
module letter(l,letter_size) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  linear_extrude(height = letter_height,convexity=4) {
    text(l, size = letter_size, font = font, halign = "left", valign = "center", $fn = 16);
  }
}

$fn = 75;

include <FTM-350 Mount Dimensions.scad>;

front_face = [face_width,face_height,wall_thickness];
text_coords = [62,0,wall_thickness-engrave_depth];
top_plate_xy = [(face_width - cubby_width),(face_height - wall_thickness),0];
bottom_plate_xy = [(face_width - cubby_width),0,0];
fastener_dia = 1.75;

top_left_screwhole = top_plate_xy + [fastener_dia*3,-fastener_dia,0];
top_right_screwhole = top_plate_xy + [cubby_width-(fastener_dia*3),-fastener_dia,0];
bottom_left_screwhole = bottom_plate_xy + [fastener_dia*3,fastener_dia*3.5,0];
bottom_right_screwhole = bottom_plate_xy + [cubby_width-(fastener_dia*3),fastener_dia*3.5,0];

module countersunk_screwhole(coords, wt=wall_thickness, d=fastener_dia) {
    // TODO: programmatically calculate countersink dimensions
    translate(coords + [0,0,-1]) cylinder(wt*1.5,r=d);
    translate(coords + [0,0,wt*0.6]) cylinder(r2=5.6/2,r1=3/2,h=1.7); // countersink
}

difference() {
    // Front face
    cube(front_face);

    // Text
    translate(text_coords+[0,27,0]) letter("AK6L",12);
    translate(text_coords+[0,15,0]) letter("Radio Head Mount",4.5);
    translate(text_coords+[0,9,0])  letter("for 4Runner Dash",4.5);
    
    // Inset for head joint
    translate([25,face_height/2,wall_thickness]) cylinder(wall_thickness,r=18,center=true);
    
    // Screw holes for head joint
    mirror([0,0,1]) translate([0,0,-4]) countersunk_screwhole([12,face_height/2,-0.05]);
    mirror([0,0,1]) translate([0,0,-4]) countersunk_screwhole([38,face_height/2,-0.05]);

    // Screw holes for top plate
    countersunk_screwhole(top_left_screwhole);
    countersunk_screwhole(top_right_screwhole);
    countersunk_screwhole(bottom_left_screwhole);
    countersunk_screwhole(bottom_right_screwhole);
}

%translate(top_plate_xy + [0,0,-plate_depth])    cube([cubby_width,wall_thickness,plate_depth]);
%translate(bottom_plate_xy + [0,0,-plate_depth]) cube([cubby_width,wall_thickness,plate_depth]);

