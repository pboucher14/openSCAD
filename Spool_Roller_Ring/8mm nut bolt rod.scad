/* Author: Mike Thompson 21/7/2013, Thingiverse: mike_linus
 *
 * This script contains a few examples to generate 8mm nuts, bolts and threaded rod 
 * to illustrate how to use the modules included in the original library 
 * script: polyScrewThead.scad (modified/updated version polyScrewThread_r1.scad)
 * http://www.thingiverse.com/thing:8796, CC Public Domain
 *
 * Examples are for a 8mm diameter bolts, rod, matching nuts and wing nuts.
 * Note: the examples should produce matching sets that work together without cleanup
 * or modification. Some paramters such as the nut outer diameter are deliberately
 * altered to produce a snug fit that can still be hand tightened. 
 *
 * Note compilation and rendering times can be significant if mutiple objects are generated. 
 */

include <polyScrewThread_r1.scad>

/* Example 01 - 8mm x 25mm bolt
 *
 * hex_screw(8,  // Outer diameter of the thread
 *            2,  // Thread step
 *           45,  // Step shape degrees
 *           25,  // Length of the threaded section of the screw
 *          1.5,  // Resolution (face at each 2mm of the perimeter)
 *            2,  // Countersink in both ends
 *           12,  // Distance between flats for the hex head
 *            5,  // Height of the hex head (can be zero)
 *            0,  // Length of the non threaded section of the screw
 *            0)  // Diameter for the non threaded section of the screw
 *                     -1 - Same as inner diameter of the thread
 *                      0 - Same as outer diameter of the thread
 *                  value - The given value
 *
 */

hex_screw(8,2,45,25,1.5,2,12,5,0,0);

/* Example 02 - Nut to suit 8mm bolt (slightly larger outer diameter to fit on bolt correctly)
 *
 * hexa_nut(12,  // Distance between flats
 *           6,  // Height 
 *           2,  // Step height (the half will be used to countersink the ends)
 *          45,  // Degrees (same as used for the screw_thread example)
 *          9.5,  // Outer diameter of the thread to match
 *         0.5)  // Resolution, you may want to set this to small values
 *                  (quite high res) to minimize overhang issues
 *
 */

//hex_nut(12,6,2,45,9.5,0.5);

/* Example 03 - Wing Nut variation of 8mm hex nut
 * Cylinders added to each side of nut for easy turning - ideal for quick release applications
 */

/*
difference() //wing nut
{
	union()
	{
		hex_nut(12,6,2,45,9.5,0.5); //nut
		translate([10.5,1.5,4])rotate([90,0,0])cylinder(r=6,h=3); //attach cylinder
		mirror(1,0,0)translate([10.5,1.5,4])rotate([90,0,0])cylinder(r=6,h=3); //attach cylinder
	}
	translate([-15,-15,-3])cube([30,30,3]); //remove overhang so flush with base of nut
}
*/

/* Example 04 - 8mm x 120mm threaded rod
 *
 * hex_screw(8,  // Outer diameter of the thread
 *            2,  // Thread step
 *           45,  // Step shape degrees
 *           120,  // Length of the threaded section of the screw
 *          1.5,  // Resolution (face at each 2mm of the perimeter)
 *            2,  // Countersink in both ends
 *           12,  // Distance between flats for the hex head
 *            0,  // Height of the hex head (can be zero)
 *            0,  // Length of the non threaded section of the screw
 *            0)  // Diameter for the non threaded section of the screw
 *                     -1 - Same as inner diameter of the thread
 *                      0 - Same as outer diameter of the thread
 *                  value - The given value
 *
 */

//hex_screw(8,2,45,120,1.5,2,12,0,0,0);