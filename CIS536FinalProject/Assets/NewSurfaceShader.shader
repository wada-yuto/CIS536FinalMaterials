Shader "Mobile/Shader-Unlit"{
    Properties{
      _Color("Tint", Color) = (0, 0, 0, 1)
      _MainTex("Texture", 2D) = "white" {}
    }

        SubShader{
        Tags{ "RenderType" = "Opaque" "Queue" = "Geometry" }

        Pass{
          CGPROGRAM

          //include useful shader functions
          #include "UnityCG.cginc"
          #pragma vertex vert
          #pragma fragment frag

          sampler2D _MainTex;
          float4 _MainTex_ST;

          //tint of the texture
          fixed4 _Color;

          struct appdata {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
          };
          struct v2f {
            float4 position : SV_POSITION;
            float2 uv : TEXCOORD0;
          };

          //the vertex shader function
          v2f vert(appdata v) {
            v2f o;
            o.position = UnityObjectToClipPos(v.vertex);
            o.uv = TRANSFORM_TEX(v.uv, _MainTex);
            return o;
          }

          //the fragment shader function
          fixed4 frag(v2f i) : SV_TARGET{
              //read the texture color at the uv coordinate
              fixed4 col = tex2D(_MainTex, i.uv);
              //multiply the texture color and tint color
              col *= _Color;
              //return the final color to be drawn on screen
              return col;
            }

        ENDCG
      }
    }
        Fallback "VertexLit"
}