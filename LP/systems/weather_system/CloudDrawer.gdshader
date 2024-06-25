shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	  float edge = 0.3;
      float edgeMin = edge;
      float edgeMax = 1.0 - edge;
      // dx => lilnear distance parallel to x from UV to rectangle
      // (0.5, 0.5) is the center of the rectangle in uv
      // the abs and max work together to make any UV inside the 
      // rectangle return 0
      float dx = max(abs(UV.x - 0.5) - (0.5 - edge), 0.);
      // similarly for dy, along the parallel to y
      float dy = max(abs(UV.y - 0.5) - (0.5 - edge), 0.);
      // d is the result of a Euclidean distance; this rounds the corners
      float d = sqrt(dx * dx + dy * dy);
      // alpha should be opacity at the edge of the rectangle, and also 
      // inside of it (all where d == 0), and 0. at the edge of the plane
      // (where d == edge).  So we do an inverse lerp.
      float opacity = COLOR.a;
      COLOR.a= opacity - opacity * d / edge;

}
