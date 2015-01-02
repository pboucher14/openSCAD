/*************************************************************************** 
Spring seat to maintain spring alignment and even pressure when compressed.
Author: Mike Thompson (thingyverse: mike_linus)
Date Last Modified: 16/03/2013
Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.  Further 
information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB

Description: change the variable values to print an inside or outside seat of the required dimensions.  The inside seat is more compact for tighter spaces.  The outside version hides the base of the spring for but looks chunkier.
****************************************************************************/

/*globals*/
resolution=50;
bolt_hole_radius=2.5;
seat_radius=5;
support_height=3;
//"inside" or "outside"
seat_type="inside";
thickness=1;

$fn=resolution;

module base(){
	cylinder(r=seat_radius,h=thickness);
	cylinder(r=seat_radius-thickness-0.25,h=support_height);
}

if (seat_type=="inside"){
	difference(){
		base();
		cylinder(r=bolt_hole_radius,h=support_height);
	}
}
else {
	difference(){
		cylinder(r=seat_radius+thickness,h=support_height);
		translate([0,0,thickness])cylinder(r=seat_radius,h=support_height);
		cylinder(r=bolt_hole_radius,h=support_height);
	}
}
