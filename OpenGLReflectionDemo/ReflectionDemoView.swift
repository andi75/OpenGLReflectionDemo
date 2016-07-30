//
//  ReflectionDemoView.swift
//  OpenGLReflectionDemo
//
//  Created by Andreas Umbach on 28.07.2016.
//  Copyright © 2016 Andreas Umbach. All rights reserved.
//

import Cocoa
import OpenGL
import GLKit
import GLUT
// let M_PI = Darwin.M_PI

class ReflectionDemoView : NSOpenGLView
{
    let glut = OpenGLUtilities()
    var phi : Float = 0
    var chi : Float = 0
    
    override func drawRect(dirtyRect: NSRect) {
        render(width: dirtyRect.width, height: dirtyRect.height)
        glFlush()
    }
    
    func render(width width: CGFloat, height: CGFloat)
    {
        glClearColor(0, 0, 0.2, 0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT))
        
        glViewport(0, 0, GLsizei(width), GLsizei(height))
        
        // setup matrices
        glMatrixMode(GLenum(GL_PROJECTION))
        // let proj = GLKMatrix4MakeOrtho(0, Float(terrain.width), 0, Float(terrain.height), 0, 100)
        
        // let proj = GLKMatrix4MakeOrtho(-d, d, -d, d, 0, 4 * d)
        
        let d : Float = 2.0
        
        let proj = GLKMatrix4MakePerspective( Float(M_PI) / 4.0, Float(width / height), d, 100 * d)
        glLoadMatrixf(glut.glMatrix(proj))
        
        glMatrixMode(GLenum(GL_MODELVIEW))
        glLoadIdentity()
        let lightPos : [Float] = [0, 0, 1, 0]
        glLightfv( GLenum(GL_LIGHT0), GLenum(GL_POSITION), lightPos  )
        
        let view = GLKMatrix4MakeLookAt(
//            4.5, 0.5, 0.5,
            5.0, 1.5, 3.0,
            0.5, 0.5, 0.5,
            0, 0, 1
        )
        glLoadMatrixf(glut.glMatrix(view))
        
        // glPolygonMode(GLenum(GL_FRONT_AND_BACK), GLenum(GL_LINE))
        glColor4f(1, 1, 1, 1)

        glEnable(GLenum(GL_LIGHTING))
        glEnable(GLenum(GL_LIGHT0))
        
        
        glEnable( GLenum(GL_DEPTH_TEST) )
        
        // glRotatef(chi, 1, 0, 0)
        glTranslatef(0.5, 0.5, 0.5)
        glRotatef(phi, 0, 0, 1)
        glRotatef(chi, 1, 0, 0)
        glTranslatef(-0.5, -0.5, -0.5)
        glut.pushCubeGeometry()
        
        // draw a reflector to the stencil buffer
        // setup reflection matrix
        // setup clipplane
        // draw the reflected object with stencil test
        // disable clipplane
        // restore normal view matrix
        // draw the reflector with blending
        // draw the normal object
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        var dx : Int32 = 0, dy : Int32 = 0
        CGGetLastMouseDelta(&dx, &dy)
        // Swift.print("delta: \(dx), \(dy)")
        
        self.phi += Float(-dx) * 0.5
        self.chi += Float(dy) * 0.5
        
        self.needsDisplay = true
    }
}
