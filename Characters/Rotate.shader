shader_type canvas_item;
render_mode blend_mix;

void vertex(){
	COLOR.z = 1.0;
	
	//Rotate around y axis
	float delta = 2.0;
	float x = sin(TIME*delta);
	float y = -cos(TIME*delta);
	vec2 i = vec2(x,y);
	vec2 j = vec2(y,-x);
	VERTEX.xy = mat2(i,j) 
				* VERTEX.xy;
	COLOR.xy = mat2(i,j)
				* VERTEX.xy;
////	if (VERTEX.x < 0.0){
//		VERTEX.xy -= mat2(
//						vec2(cos(TIME*.2),-sin(TIME*.2)),
//						vec2(-sin(TIME*.2),cos(TIME*.2))) 
//					* VERTEX.xy;
//		COLOR.xy += mat2(
//						vec2(cos(TIME),sin(TIME)),
//						vec2(sin(TIME),cos(TIME)))
//					* COLOR.xy;
//	}

	
	
	
}