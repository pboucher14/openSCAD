/*Simple Fillet Library v1.0 by Mike Thompson 3/1/2015, Thingiverse: mike_linus
* v1.1 18/1/2015 added ability to change profile angle for ring fillet
* This software is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.
* Further information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB
*
* This library generates basic fillets using the following functions:
* - linear_fillet (straight edges)
* - corner_fillet (90 degree corners)
* - ring_fillet (cylinders - inside and outside)
* - profile (generates the 2d profile used to set the fillet shape)
* 
* There are more advanced fillet libraries and functions available such as the excellent:
* https://github.com/clothbot/ClothBotCreations/blob/master/utilities/fillet.scad
* however, sometimes you just need a basic fillet with a low computational overhead that can be applied 
* quickly and easily to selected objects :)  
*/

$fn=100;

//basic 2d profile used for fillet shape
module profile(radius)
{
  difference()
  {
    square(radius);
    circle(r=radius);
  }
}

//ring fillet for use around cylindrical objects. Set profile angle to 180 for outside fillet and 270 for inside.
module ring_fillet(ring_radius,profile_radius,profile_angle)
{
	translate([0,0,profile_radius])rotate_extrude(convexity=10)translate([ring_radius,0,0])rotate([0,0,profile_angle])profile(profile_radius);
}

//linear fillet for use along straight edges
module linear_fillet(length,profile_radius)
{
	translate([0,-profile_radius,profile_radius])rotate([0,90,0])linear_extrude(height=length,convexity=10)profile(profile_radius);
}

//corner fillet for use on 90 degree corners
module corner_fillet(corner_radius,profile_radius,profile_angle)
{
	intersection()
	{
		linear_fillet(corner_radius,profile_radius);
		translate([0,-corner_radius,0])rotate([0,0,90])linear_fillet(corner_radius,profile_radius);
	}
}

/************************************************************************************************
* EXAMPLE
* Note - small changes in translated position and radius have been made to ensure the object is 
* manifold (touching at least two sides) for stl generation
*************************************************************************************************/

//base
color("LimeGreen")cube([95,95,2]);

/*************************
* cube tower
**************************/
//create tower and subtract linear fillets from top
difference()
{
	color("LimeGreen")translate([10,55,2])cube([30,30,50]);
	//take away side fillets inverted and flipped
	translate([0,0,52.001])mirror([0,0,1])union()
	{	
		translate([10,85.001,0])linear_fillet(30,10);
		translate([9.999,55,0])rotate([0,0,90])linear_fillet(30,10);
		translate([40,54.999,0])rotate([0,0,180])linear_fillet(30,10);
		translate([40.001,85,0])rotate([0,0,270])linear_fillet(30,10);
	}
}
//add side fillets to base
translate([10,55.001,1.999])linear_fillet(30,10);
translate([39.999,55,1.999])rotate([0,0,90])linear_fillet(30,10);
translate([40,84.999,1.999])rotate([0,0,180])linear_fillet(30,10);
translate([10.001,85,1.999])rotate([0,0,270])linear_fillet(30,10);
//add corner fillets to base
translate([40,55,2])corner_fillet(10.001,10);
translate([40,85,2])rotate([0,0,90])corner_fillet(10.001,10);
translate([10,85,2])rotate([0,0,180])corner_fillet(10.001,10);
translate([10,55,2])rotate([0,0,270])corner_fillet(10.001,10);

/*************************
* small hollow cube
**************************/
//create hollow cube
difference()
{
	color("LimeGreen")translate([52.5,52.5,2])cube([40,40,10]);
	color("LimeGreen")translate([53.5,53.5,2])cube([38,38,11]);
}
//add inside linear fillets
translate([53,92,2])linear_fillet(39,10);
translate([53,53,2])rotate([0,0,90])linear_fillet(39,10);
translate([92,53,2])rotate([0,0,180])linear_fillet(39,10);
translate([92,92,2])rotate([0,0,270])linear_fillet(39,10);

/*************************
* cylinder tower
**************************/
//create cylinder and subtract ring fillet from top
difference() 
{
	color("LimeGreen")translate([70,25,2])cylinder(r=15,h=50);
	translate([70,25,52.001])rotate([180,0,0])ring_fillet(5.001,10,270);
}
//add ring fillet to base
translate([70,25,2])ring_fillet(25,10,180);

/*************************
* small hollow cylinder
**************************/
//create hollow cylinder
difference()
{
	color("LimeGreen")translate([22.5,22.5,2])cylinder(r=20,h=10);
	color("LimeGreen")translate([22.5,22.5,2])cylinder(r=19,h=11);
}
//add inside ring fillet
translate([22.5,22.5,2])ring_fillet(9,10,270);