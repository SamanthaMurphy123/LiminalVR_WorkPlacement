// Made with Amplify Shader Editor v1.9.0.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Japanese/OnsenWater"
{
	Properties
	{
		_WaterNormal("WaterNormal", 2D) = "bump" {}
		_Distortion("Distortion", Float) = 0.54
		_Waterfalloff("Water falloff", Float) = 0
		_Waterdepth("Water depth", Range( 0 , 5)) = 0.74
		_WaterColor("Water Color", Float) = -1.25
		_ShalowColor("Shalow Color", Color) = (0.4773465,0.8014706,0.6807622,0)
		_DeepColor("DeepColor", Color) = (0.2114537,0.3455882,0.1194312,0)
		_Distortion2("Distortion2", Vector) = (-0.33,-0.81,0,0)
		_Distortion1("Distortion1", Vector) = (0.7,0.65,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma exclude_renderers xboxseries playstation switch nomrt 
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _WaterNormal;
		uniform float2 _Distortion1;
		uniform float2 _Distortion2;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float _Distortion;
		uniform float4 _ShalowColor;
		uniform float4 _DeepColor;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Waterdepth;
		uniform float _Waterfalloff;
		uniform float _WaterColor;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner11 = ( 0.08 * _Time.y * _Distortion1 + i.uv_texcoord);
			float2 panner12 = ( 0.04 * _Time.y * _Distortion2 + i.uv_texcoord);
			float3 temp_output_17_0 = BlendNormals( UnpackScaleNormal( tex2D( _WaterNormal, panner11 ), 0.61 ) , UnpackScaleNormal( tex2D( _WaterNormal, panner12 ), 0.8 ) );
			o.Normal = temp_output_17_0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult23 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float4 screenColor18 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( float3( ( appendResult23 / ase_screenPosNorm.w ) ,  0.0 ) + ( _Distortion * temp_output_17_0 ) ).xy);
			float eyeDepth1 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPos.xy ));
			float4 lerpResult7 = lerp( _ShalowColor , _DeepColor , pow( ( abs( ( eyeDepth1 - ase_screenPos.w ) ) + _Waterdepth ) , _Waterfalloff ));
			float4 lerpResult28 = lerp( screenColor18 , lerpResult7 , _WaterColor);
			o.Albedo = lerpResult28.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19002
0;73;1350;926;2349.074;1218.676;2.480051;True;False
Node;AmplifyShaderEditor.Vector2Node;37;-1912.629,-438.6097;Float;False;Property;_Distortion1;Distortion1;8;0;Create;True;0;0;0;False;0;False;0.7,0.65;0.7,0.65;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-2109.038,-302.7375;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;36;-1899.513,-125.708;Float;False;Property;_Distortion2;Distortion2;7;0;Create;True;0;0;0;False;0;False;-0.33,-0.81;-0.33,-0.81;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ScreenPosInputsNode;2;-968.1799,-905.4563;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-1653.014,-5.840905;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;12;-1647.469,-180.7785;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.33,-0.81;False;1;FLOAT;0.04;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;11;-1652.412,-335.8741;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.7,0.65;False;1;FLOAT;0.08;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenDepthNode;1;-734.4679,-915.6208;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;22;-1039.712,-638.665;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-527.6117,-838.3782;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-1417.823,-306.6293;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;14;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.61;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-1422.643,-108.2135;Inherit;True;Property;_WaterNormal;WaterNormal;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;23;-801.3878,-622.3768;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendNormalsNode;17;-1016.272,-155.4663;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.AbsOpNode;4;-350.664,-830.2023;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-590.7809,-707.0002;Float;False;Property;_Waterdepth;Water depth;3;0;Create;True;0;0;0;False;0;False;0.74;0.6656335;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-975.4367,-397.2955;Float;False;Property;_Distortion;Distortion;1;0;Create;True;0;0;0;False;0;False;0.54;-0.31;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-775.3666,-392.6369;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;24;-660.1398,-575.5781;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-357.7934,-592.1024;Float;False;Property;_Waterfalloff;Water falloff;2;0;Create;True;0;0;0;False;0;False;0;1.23;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-210.6718,-748.9274;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-524.0151,-423.5442;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;6;-179.2857,-1096.15;Float;False;Property;_ShalowColor;Shalow Color;5;0;Create;True;0;0;0;False;0;False;0.4773465,0.8014706,0.6807622,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-197.64,-922.0898;Float;False;Property;_DeepColor;DeepColor;6;0;Create;True;0;0;0;False;0;False;0.2114537,0.3455882,0.1194312,0;0.3260165,0.6061928,0.6617647,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;33;-45.88469,-715.0449;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;18;-300.1371,-452.5357;Float;False;Global;_GrabScreen0;Grab Screen 0;1;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;55.55636,-393.1339;Float;False;Property;_WaterColor;Water Color;4;0;Create;True;0;0;0;False;0;False;-1.25;0.54;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;7;134.0232,-795.721;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;28;325.1347,-552.7799;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;413.0219,-23.73689;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Japanese/OnsenWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;14;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;metal;vulkan;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;10;0
WireConnection;12;2;36;0
WireConnection;11;0;10;0
WireConnection;11;2;37;0
WireConnection;1;0;2;0
WireConnection;3;0;1;0
WireConnection;3;1;2;4
WireConnection;13;1;11;0
WireConnection;14;1;12;0
WireConnection;14;5;16;0
WireConnection;23;0;22;1
WireConnection;23;1;22;2
WireConnection;17;0;13;0
WireConnection;17;1;14;0
WireConnection;4;0;3;0
WireConnection;26;0;25;0
WireConnection;26;1;17;0
WireConnection;24;0;23;0
WireConnection;24;1;22;4
WireConnection;31;0;4;0
WireConnection;31;1;30;0
WireConnection;27;0;24;0
WireConnection;27;1;26;0
WireConnection;33;0;31;0
WireConnection;33;1;34;0
WireConnection;18;0;27;0
WireConnection;7;0;6;0
WireConnection;7;1;5;0
WireConnection;7;2;33;0
WireConnection;28;0;18;0
WireConnection;28;1;7;0
WireConnection;28;2;29;0
WireConnection;0;0;28;0
WireConnection;0;1;17;0
ASEEND*/
//CHKSM=F8ED8E7B44ACB4656297C13F2C21332F901A99D0