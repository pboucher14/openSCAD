/*Simple Fillet Library by Mike Thompson 3/1/2014, Thingiverse: mike_linus
* This software is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Australia License.
* Further information is available here - http://creativecommons.org/licenses/by-nc-sa/3.0/au/deed.en_GB
*
* This library generates basic fillets using the following functions:
* - linear_fillet (straight edges)
* - corner_fillet (90 degree corners)
* - ring_fillet (cylinders)
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

//ring fillet for use around cylindrical objects
module ring_fillet(ring_radius,profile_radius)
{
	translate([0,0,profile_radius])rotate_extrude(convexity=10)translate([ring_radius+profile_radius,0,0])rotate([0,0,180])profile(profile_radius);
}

//linear fillet for use along straight edges
module linear_fillet(length,profile_radius)
{
	translate([0,-profile_radius,profile_radius])rotate([0,90,0])linear_extrude(height=length,convexity=10)profile(profile_radius);
}

//corner fillet for use on 90 degree corners
module corner_fillet(corner_radius,profile_radius)
{
	intersection()
	{
		linear_fillet(corner_radius,profile_radius);
		translate([0,-corner_radius,0])rotate([0,0,90])linear_fillet(corner_radius,profile_radius);
	}
}

/*EXAMPLE
* Note - small changes in translated position have been made to ensure the object is manifold for stl generation
*/

//build basic structure for example
color("LimeGreen")cube([95,95,2]);
color("LimeGreen")translate([10,10,2])cube([30,30,50]);
color("LimeGreen")translate([70,70,2])cylinder(r=15,h=50);

//add fillets
//sides
translate([9.99,9.99,1.99])linear_fillet(30,10);
translate([9.99,9.99,1.99])linear_fillet(30,10);
translate([39.99,10,1.99])rotate([0,0,90])linear_fillet(30,10);
translate([39.99,39.99,1.99])rotate([0,0,180])linear_fillet(30,10);
translate([9.99,39.99,1.99])rotate([0,0,270])linear_fillet(30,10);

//corners
translate([40,10,2])corner_fillet(10+0.01,10);
translate([40,40,2])rotate([0,0,90])corner_fillet(10.01,10);
translate([10,40,2])rotate([0,0,180])corner_fillet(10.01,10);
translate([10,10,2])rotate([0,0,270])corner_fillet(10.01,10);

//ring
translate([70,70,2])ring_fillet(15,10);