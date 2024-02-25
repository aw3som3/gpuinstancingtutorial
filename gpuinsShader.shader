Shader "Custom/gpuinsShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Tags { "ForceNoShadowCasting" = "True"}
        LOD 200
        Pass{
            CGPROGRAM
                
            fixed4 _Color;
            sampler2D _MainTex;

            #pragma vertex vert;
            #pragma fragment frag;

            struct AppData{
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;
            };
            struct v2f{
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;
            };

            v2f vert(AppData v,uint id:SV_InstanceID){
                int x=id/100;
                int y=0;
                int z=fmod(id,100);

                float xPos = x+sin(z);
                float zPos = z+sin(x);

                float3 pos = float3(xPos,y,zPos);
                float3 vertPos = v.vertex.xyz + pos;
                float4 vertPos4 = float4(vertPos,1.0);

                float4 clipPos = UnityObjectToClipPos(vertPos4);
                v2f o;
                o.vertex = clipPos;
                o.uv = v.uv;
                return o;
                
            }

            fixed4 frag(v2f i):SV_Target{
                fixed4 col = tex2D(_MainTex,i.uv);
                clip(col.a-0.5);
                return col * _Color;
            }

            ENDCG
            }
        
    }
    FallBack "Diffuse"
}
