shader_type canvas_item;

void vertex() {
	VERTEX.x += sin(VERTEX.x * TIME) + cos(VERTEX.x * TIME*.03);
	VERTEX.y += sin(VERTEX.y * TIME) + cos(VERTEX.y * TIME*.03);
	
//	VERTEX.yx = -abs(mat2(
//					vec2(1,1),
//					vec2(cos((VERTEX.x * TIME*0.03 +VERTEX.x)),cos((VERTEX.x * TIME*0.03 +VERTEX.y)))
//				)
//			* vec2(VERTEX.xy));
	
	COLOR.rgb = sin(vec3(mat3(
					vec3(0,0,0),
					vec3(0,0,0),
					vec3(0,0,sin(VERTEX.x+VERTEX.y))
				)
			* vec3(COLOR.rgb)));
			 
}