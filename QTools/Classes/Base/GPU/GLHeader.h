//
//  GLHeader.h
//
//  Created by XQ on 2022/1/29.
//

#ifndef GLHeader_h
#define GLHeader_h

#if TARGET_OS_IPHONE

#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>

#endif

#if TARGET_OS_OSX

#define GL_SILENCE_DEPRECATION

#import <OpenGL/gl.h>
#import <OpenGL/glu.h>
#import <GLUT/glut.h>

#endif

#endif /* GLHeader_h */
