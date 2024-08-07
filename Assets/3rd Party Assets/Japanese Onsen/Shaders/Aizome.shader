// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Japanese/Aizome"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_Mask("Mask", 2D) = "white" {}
		_ColorA("Color A", Color) = (1,1,1,0)
		_ColorB("Color B", Color) = (0.05882353,0.2156863,0.427451,0)
		_ColorMask("Color Mask", 2D) = "white" {}
		[Toggle(_INVERTCOLORMASK_ON)] _InvertColorMask("Invert Color Mask", Float) = 0
		_Sign1("Sign 1", 2D) = "white" {}
		[Toggle(_INVERTSIGN1_ON)] _InvertSign1("Invert Sign 1", Float) = 0
		_Sign1size("Sign 1 size", Float) = 2.87
		_Sign1position("Sign 1 position", Vector) = (0.33,0,0,0)
		_Sing2("Sing 2", 2D) = "white" {}
		[Toggle(_INVERTSIGN2_ON)] _InvertSign2("Invert Sign 2", Float) = 0
		_Sign2size("Sign 2 size", Float) = 2.87
		_Sign2position("Sign 2 position", Vector) = (0.33,0,0,0)
		_Sing3("Sing 3", 2D) = "white" {}
		[Toggle(_INVERTSIGN3_ON)] _InvertSign3("Invert Sign 3", Float) = 0
		_Sign3size("Sign 3 size", Float) = 2.87
		_Sign3position("Sign 3 position", Vector) = (0.33,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _INVERTSIGN1_ON
		#pragma shader_feature _INVERTSIGN2_ON
		#pragma shader_feature _INVERTSIGN3_ON
		#pragma shader_feature _INVERTCOLORMASK_ON
		#pragma exclude_renderers switch nomrt 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform sampler2D _Sign1;
		uniform float _Sign1size;
		uniform float2 _Sign1position;
		uniform sampler2D _Sing2;
		uniform float _Sign2size;
		uniform float2 _Sign2position;
		uniform sampler2D _Sing3;
		uniform float _Sign3size;
		uniform float2 _Sign3position;
		uniform sampler2D _ColorMask;
		uniform float4 _ColorMask_ST;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float2 temp_cast_0 = (_Sign1size).xx;
			float2 uv_TexCoord33 = i.uv_texcoord * temp_cast_0 + _Sign1position;
			float4 tex2DNode11 = tex2D( _Sign1, uv_TexCoord33 );
			#ifdef _INVERTSIGN1_ON
				float4 staticSwitch51 = tex2DNode11;
			#else
				float4 staticSwitch51 = ( 1.0 - tex2DNode11 );
			#endif
			float2 temp_cast_1 = (_Sign2size).xx;
			float2 uv_TexCoord44 = i.uv_texcoord * temp_cast_1 + _Sign2position;
			float4 tex2DNode21 = tex2D( _Sing2, uv_TexCoord44 );
			#ifdef _INVERTSIGN2_ON
				float4 staticSwitch52 = tex2DNode21;
			#else
				float4 staticSwitch52 = ( 1.0 - tex2DNode21 );
			#endif
			float2 temp_cast_2 = (_Sign3size).xx;
			float2 uv_TexCoord47 = i.uv_texcoord * temp_cast_2 + _Sign3position;
			float4 tex2DNode20 = tex2D( _Sing3, uv_TexCoord47 );
			#ifdef _INVERTSIGN3_ON
				float4 staticSwitch53 = tex2DNode20;
			#else
				float4 staticSwitch53 = ( 1.0 - tex2DNode20 );
			#endif
			float grayscale16 = Luminance(saturate( ( staticSwitch51 + staticSwitch52 + staticSwitch53 ) ).rgb);
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 tex2DNode10 = tex2D( _ColorMask, uv_ColorMask );
			#ifdef _INVERTCOLORMASK_ON
				float4 staticSwitch54 = tex2DNode10;
			#else
				float4 staticSwitch54 = ( 1.0 - tex2DNode10 );
			#endif
			float grayscale15 = Luminance(staticSwitch54.rgb);
			float lerpResult17 = lerp( grayscale16 , grayscale15 , staticSwitch54.r);
			float4 lerpResult9 = lerp( _ColorA , _ColorB , lerpResult17);
			o.Albedo = ( tex2D( _Albedo, uv_Albedo ) * lerpResult9 ).rgb;
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode3 = tex2D( _Mask, uv_Mask );
			o.Metallic = tex2DNode3.r;
			o.Smoothness = tex2DNode3.a;
			o.Occlusion = tex2DNode3.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18912
0;73;1132;927;591.0932;349.4936;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;42;-2874.295,-188.8747;Float;False;Property;_Sign2size;Sign 2 size;13;0;Create;True;0;0;0;False;0;False;2.87;4.87;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;43;-2890.295,-60.87479;Float;False;Property;_Sign2position;Sign 2 position;14;0;Create;True;0;0;0;False;0;False;0.33,0;-0.06,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;40;-2890.295,-348.8747;Float;False;Property;_Sign1position;Sign 1 position;10;0;Create;True;0;0;0;False;0;False;0.33,0;-0.41,-0.18;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;41;-2874.295,-476.8747;Float;False;Property;_Sign1size;Sign 1 size;9;0;Create;True;0;0;0;False;0;False;2.87;1.89;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-2890.295,99.12524;Float;False;Property;_Sign3size;Sign 3 size;17;0;Create;True;0;0;0;False;0;False;2.87;2.43;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;46;-2906.295,227.1253;Float;False;Property;_Sign3position;Sign 3 position;18;0;Create;True;0;0;0;False;0;False;0.33,0;0.33,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;-2650.295,-124.8748;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;33;-2650.295,-412.8747;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-2666.295,163.1253;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;21;-2378.295,-252.8747;Inherit;True;Property;_Sing2;Sing 2;11;0;Create;True;0;0;0;False;0;False;-1;None;4f217d641a4911b438eb7413f5ef2b86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-2394.295,-60.87479;Inherit;True;Property;_Sing3;Sing 3;15;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-2391.704,-518.2688;Inherit;True;Property;_Sign1;Sign 1;7;0;Create;True;0;0;0;False;0;False;-1;None;111462b9d5187244d8300b660f3184cc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;36;-2062.009,-516.079;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;37;-2056.721,-282.615;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;38;-2048.736,-151.6731;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;51;-1877.485,-400.6953;Float;False;Property;_InvertSign1;Invert Sign 1;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;53;-1869.414,-147.9679;Float;False;Property;_InvertSign3;Invert Sign 3;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;10;-2063.272,278.2659;Inherit;True;Property;_ColorMask;Color Mask;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;52;-1869.295,-248.8747;Float;False;Property;_InvertSign2;Invert Sign 2;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;55;-1712.273,121.2659;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1603.133,-267.596;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;39;-1375.885,-269.1716;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;54;-1528.016,123.0165;Float;False;Property;_InvertColorMask;Invert Color Mask;6;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCGrayscale;15;-1213.261,-194.2733;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;16;-1208.276,-277.7588;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-969.0002,-460.1621;Float;False;Property;_ColorB;Color B;4;0;Create;True;0;0;0;False;0;False;0.05882353,0.2156863,0.427451,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;17;-971.4589,-276.0196;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-983.4282,-680.0436;Float;False;Property;_ColorA;Color A;3;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.5514706,0.117593,0.117593,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-666.5718,-530.762;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-703.4955,-790.6984;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;0;False;0;False;-1;None;bc4a35bc836d30c48828d2b79c2f97a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-332.579,-71.65247;Inherit;True;Property;_Mask;Mask;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-333.6299,-299.895;Inherit;True;Property;_Normal;Normal;1;0;Create;True;0;0;0;False;0;False;-1;None;d8782e7cc89d37e40a073f0aecbaedc8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-249.3066,-632.3367;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;114.4805,-233.6336;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Japanese/Aizome;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;44;0;42;0
WireConnection;44;1;43;0
WireConnection;33;0;41;0
WireConnection;33;1;40;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;21;1;44;0
WireConnection;20;1;47;0
WireConnection;11;1;33;0
WireConnection;36;0;11;0
WireConnection;37;0;21;0
WireConnection;38;0;20;0
WireConnection;51;1;36;0
WireConnection;51;0;11;0
WireConnection;53;1;38;0
WireConnection;53;0;20;0
WireConnection;52;1;37;0
WireConnection;52;0;21;0
WireConnection;55;0;10;0
WireConnection;26;0;51;0
WireConnection;26;1;52;0
WireConnection;26;2;53;0
WireConnection;39;0;26;0
WireConnection;54;1;55;0
WireConnection;54;0;10;0
WireConnection;15;0;54;0
WireConnection;16;0;39;0
WireConnection;17;0;16;0
WireConnection;17;1;15;0
WireConnection;17;2;54;0
WireConnection;9;0;6;0
WireConnection;9;1;8;0
WireConnection;9;2;17;0
WireConnection;5;0;1;0
WireConnection;5;1;9;0
WireConnection;0;0;5;0
WireConnection;0;1;2;0
WireConnection;0;3;3;1
WireConnection;0;4;3;4
WireConnection;0;5;3;2
ASEEND*/
//CHKSM=FC30A8EECA5416EABF9B964EF4A9FFDE91192BB3