//
//  PeopleSecretKeybord.h
//  TestKeyBord
//
//  Created by Wilon on 16/4/27.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#ifndef PeopleSecretKeybord_h
#define PeopleSecretKeybord_h

#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

    
//extern  JNICALL Java_com_zryf_sotp_KeyBoard_GetEncKey (JNIEnv *env, jclass obj, jint key);
//    JNIEXPORT jstring JNICALL Java_com_zryf_sotp_KeyBoard_GetEncKey
//    (JNIEnv *env, jclass obj, jint key)

extern unsigned char *ava_com_zryf_sotp_KeyBoard_GetEncKey( obj, long key);

//    const void *data, CC_LONG len, unsigned char *md
    
#ifdef __cplusplus
}
#endif

#endif /* PeopleSecretKeybord_h */
