using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AdjustPivot : MonoBehaviour
{
    public Vector3 newPivotPosition;

    void Start()
    {
        Mesh mesh = GetComponent<MeshFilter>().mesh;
        Vector3[] vertices = mesh.vertices;

        for (int i = 0; i < vertices.Length; i++)
        {
            vertices[i] -= newPivotPosition;
        }

        mesh.vertices = vertices;
        mesh.RecalculateBounds();

        transform.position += newPivotPosition;
    }
}
