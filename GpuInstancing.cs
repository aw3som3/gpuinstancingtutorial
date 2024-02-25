using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GpuInstancing : MonoBehaviour
{
    public Mesh mesh;
    public Material material;

    private ComputeBuffer argsBuffer;

    // Start is called before the first frame update
    void Start()
    {
        argsBuffer = new ComputeBuffer(1, 5 * sizeof(uint), ComputeBufferType.IndirectArguments);

        uint[] args = new uint[5] { 0,0,0,0,0};

        args[0] = mesh.GetIndexCount(0);
        args[1] = 10000;
        args[2] = mesh.GetIndexStart(0);
        args[3] = mesh.GetBaseVertex(0);
        args[4] = 0;

        argsBuffer.SetData(args);
    }

    // Update is called once per frame
    void Update()
    {
        Bounds bounds = new Bounds(Vector3.zero,new Vector3(100,100,100));
        Graphics.DrawMeshInstancedIndirect(mesh, 0, material, bounds, argsBuffer);
        
    }
}
