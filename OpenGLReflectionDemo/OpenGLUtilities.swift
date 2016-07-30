//
//  OpenGLUtilities.swift
//  OpenGLReflectionDemo
//
//  Created by Andreas Umbach on 28.07.2016.
//  Copyright © 2016 Andreas Umbach. All rights reserved.
//

//import Foundation
//import CoreGraphics
//import Cocoa
//import GLKit
//import OpenGL
import Cocoa
import OpenGL
import GLKit
import GLUT
let M_PI = Darwin.M_PI

// sides bottom top left right are from (1.5, 0.5, 0.5) viewing in direction (-1, 0, 0)

let cubeVertices : [Float] = [
    0, 0, 0, // bottom
    0, 1, 0,
    1, 1, 0,
    1, 0, 0,
    0, 0, 1, // top
    1, 0, 1,
    1, 1, 1,
    0, 1, 1,
    0, 0, 0, // left
    1, 0, 0,
    1, 0, 1,
    0, 0, 1,
    0, 1, 0, // right
    0, 1, 1,
    1, 1, 1,
    1, 1, 0,
    1, 0, 0, // front
    1, 1, 0,
    1, 1, 1,
    1, 0, 1,
    0, 0, 0, // back
    0, 0, 1,
    0, 1, 1,
    0, 1, 0
];

let cubeNormals : [Float] = [
    0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, // bottom
    0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, // top
    0, -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 0, // left
    0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, // right
    1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, // front
    -1, 0, 0, -1, 0, 0, -1, 0, 0, -1, 0, 0 // back
]

let cubeIndices : [UInt32] = [
    0, 1, 2, 0, 2, 3, // bottom
    4, 5, 6, 4, 6, 7, // top
    8, 9, 10, 8, 10, 11, // left
    12, 13, 14, 12, 14, 15, // right
    16, 17, 18, 16, 18, 19, // front
    20, 21, 22, 20, 22, 23 // back
];

let squasreVertices : [Float] = [
    0, 0, 0,
    0, 1, 0,
    1, 1, 0,
    1, 0, 0
];

let squareNormals : [Float] = [
    0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1
];

class OpenGLUtilities
{
    func glMatrix(mat : GLKMatrix4) -> [Float]
    {
        return [
            mat.m00, mat.m01, mat.m02, mat.m03,
            mat.m10, mat.m11, mat.m12, mat.m13,
            mat.m20, mat.m21, mat.m22, mat.m23,
            mat.m30, mat.m31, mat.m32, mat.m33
        ]
    }

    func pushCubeGeometry()
    {
        glVertexPointer(3, GLenum(GL_FLOAT), 0, cubeVertices)
        glNormalPointer(GLenum(GL_FLOAT), 0, cubeNormals)
        glEnableClientState(GLenum(GL_VERTEX_ARRAY))
        glEnableClientState(GLenum(GL_NORMAL_ARRAY))
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(cubeIndices.count), GLenum(GL_UNSIGNED_INT), cubeIndices)
        glDisableClientState(GLenum(GL_NORMAL_ARRAY))
        glDisableClientState(GLenum(GL_VERTEX_ARRAY))
    }
    
    func pushSquareGeometry()
    {
        glVertexPointer(3, GLenum(GL_FLOAT), 0, squasreVertices)
        glNormalPointer(GLenum(GL_FLOAT), 0, squareNormals)
        glEnableClientState(GLenum(GL_VERTEX_ARRAY))
        glEnableClientState(GLenum(GL_NORMAL_ARRAY))
        glDrawArrays(GLenum(GL_QUADS), 0, 4)
        glDisableClientState(GLenum(GL_NORMAL_ARRAY))
        glDisableClientState(GLenum(GL_VERTEX_ARRAY))
    }
}

