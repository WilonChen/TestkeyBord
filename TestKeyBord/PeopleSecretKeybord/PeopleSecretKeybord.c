//
//  PeopleSecretKeybord.c
//  TestKeyBord
//
//  Created by Wilon on 16/4/27.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#include "PeopleSecretKeybord.h"

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>

//#ifdef ANDROID
//#include <jni.h>
//#include <android/log.h>
//#define LOG_TAG    "SOTPjni"
//#define LOGE(...)  __android_log_print(ANDROID_LOG_DEBUG,LOG_TAG,__VA_ARGS__)
//#endif


#ifdef DEBUG //调试状态，打印log日志
#define PPLog(...) NSLog(__VA_ARGS__)
#else   //发布状态，关闭log日志
#define PPLog(...)
#endif

//#include "com_zryf_sotp_KeyBoard.h"
//#include "md5.h"

#include <CommonCrypto/CommonDigest.h>
/**
 * 这个结构体是干什么的呢？  需要考虑
 */
typedef struct KeyMap{
    int key;
    char value[20];
}KeyMap_t;

KeyMap_t keyMapArray[256];
volatile int flag = 1;

void refushMap()
{
    int i, j, len;
    time_t xx = time(NULL);
    srand((unsigned int)(10000 * (xx % RAND_MAX)));
    
    for(i = 0; i < sizeof(keyMapArray)/sizeof(keyMapArray[0]); i++)
    {
        snprintf(keyMapArray[i].value, sizeof(keyMapArray[i].value)-4, "%lf", rand()*10000/(float)(RAND_MAX) + 1);
        sprintf(keyMapArray[i].value+strlen(keyMapArray[i].value)-1,"%03d", i);
        
        
        len = strlen(keyMapArray[i].value);
        for(j = 0; j < len; j++)
            keyMapArray[i].value[j] += 'a' - '.';
    }
    
    return ;
}

//JNIEXPORT jstring JNICALL Java_com_zryf_sotp_KeyBoard_GetEncKey
//(JNIEnv *env, jclass obj, jint key)
extern unsigned char *ava_com_zryf_sotp_KeyBoard_GetEncKey(const void *obj, long key)
{
    char buf[20];
    memset(buf, 0x00, sizeof(buf));
    if(flag == 1)
    {
        refushMap();
        flag = 0;
    }
    if(key < 0 || key >= sizeof(keyMapArray)/sizeof(keyMapArray[0]))
    {
        //	(*env)->ThrowNew(env, (*env)->FindClass(env, "java/lang/Exception"), "key value outof ranges(0 - 256)");
        return NULL;
    }
    snprintf(buf, sizeof buf, "%s", keyMapArray[key].value);
//    jstring jStr = (*env)->NewStringUTF(env, buf);
//    char *jStr =
    return jStr;
}
/*
 JNIEXPORT jint JNICALL Java_com_zryf_sotp_KeyBoard_GetDecKey
 (JNIEnv *env, jclass obj, jstring value)
 {
	jint key = 0;
	int i;
	jsize len =  (*env)->GetStringLength(env, value);
	const char *inStr = (*env)->GetStringUTFChars(env, value, 0);
	for( i =0; i < sizeof(keyMapArray)/sizeof(keyMapArray[0]); i++)
	{
 if( 0 == strncmp(inStr, keyMapArray[i].value, len))
 return keyMapArray[i].key;
 return i;
	}
	return -1;
 }*/

static int dec_value (char *value, int n)
{
    int  key = 0;
    int i;
    jsize len = n;
    const char *inStr = value;
    for( i =0; i < sizeof(keyMapArray)/sizeof(keyMapArray[0]); i++)
    {
        if( 0 == strncmp(inStr, keyMapArray[i].value, len))
        /*return keyMapArray[i].key;*/
            return i;
    }
    return -1;
}

JNIEXPORT void JNICALL Java_com_zryf_sotp_KeyBoard_FreshKeyMap
(JNIEnv *env, jclass obj)
{
    flag = 1;
    return ;
}

/*
 * Class:     com_zryf_sotp_KeyBoard
 * Method:    getSeedString
 * Signature: (Ljava/lang/String;)Ljava/lang/String;
 */
static unsigned char utfHash[128] = "hello world";
JNIEXPORT jstring JNICALL Java_com_zryf_sotp_KeyBoard_getSeedString
(JNIEnv *env, jclass obj)
{
    int len;
    CC_MD5_CTX x;
    int i = 0, j;
    unsigned char out[20],  ctimeStr[64];
    
    memset(out, 0x00, sizeof(out));
    memset(utfHash, 0x00, sizeof(utfHash));
    memset(ctimeStr, 0x00, sizeof(ctimeStr));
    
    len = snprintf(ctimeStr, sizeof ctimeStr,"%llu", time((void*)0));
    LOGE("file:%s, line:%d, output hash content:[%s]", __FILE__ , __LINE__, utfHash);
    CC_MD5_Init(&x);
    CC_MD5_Update(&x, (char *)ctimeStr, len);
    CC_MD5_Final(out, &x);
    for (i = 0; i < 16; i++) {
        sprintf((char*) (utfHash + (i * 2)), "%02X", out[i]);
    }
    
    j = i*2;
    strcat(ctimeStr, "hello");
    CC_MD5_Update(&x, (char *)ctimeStr, strlen(ctimeStr));
    CC_MD5_Final(out, &x);
    for (i = 0; i < 16; i++) {
        sprintf((char*)(utfHash+j+(i * 2)), "%02X", out[i]);
    }
    utfHash[j+i * 2] = 0;
    
    LOGE("file:%s, line:%d, output hash content:[%s]", __FILE__ , __LINE__, utfHash);
    jstring jStr = (*env)->NewStringUTF(env, utfHash);
    return jStr;
}
extern int base64_encode(const unsigned char *in, int inl, char **out);
extern void sotp_alg_crypto(const char *seed, char *inbuf, int len);
JNIEXPORT jstring JNICALL Java_com_zryf_sotp_KeyBoard_getSOTPEnc
(JNIEnv *env, jclass obj, jstring encPwd)
{
    jsize len =  (*env)->GetStringLength(env, encPwd);
    const char *inStr = (*env)->GetStringUTFChars(env, encPwd, 0);
    int i = 0, j, k;
    char tmpBuf[1024];
    char* pBuf = NULL;
    LOGE("file:%s, line:%d, input encpwd:[%s] len:%d", __FILE__ , __LINE__, inStr, len);
    memset(tmpBuf, 0x00, sizeof(tmpBuf));
    
    char xxx[1024] = {'\0'};
    j = 0;
    for(i=0; i < len; i++)
    {
        tmpBuf[i] = utfHash[i] ^ inStr[i];
        j += sprintf(xxx + j, "%d ", inStr[i]);
    }
    LOGE("file:%s, line:%d, after ^ hash:[%s] encpwd:[%s], 十进制:[%s]", __FILE__ , __LINE__, utfHash, tmpBuf, xxx);
    for(i = 0, j=0; i < len; i++)
        if(i%10 == 0)
        {
            j += sprintf(tmpBuf+200+j, "%d", dec_value(tmpBuf+ i, 10));
            LOGE("[%s]  : %d", inStr+i , dec_value(tmpBuf+ i, 10));
        }
    LOGE("dec :[%s] len:%d", tmpBuf+200, j);
    sotp_alg_crypto((void*)0, tmpBuf+200, j>=8?j:8);
    LOGE("sotp enc:[%s]", tmpBuf+200);
    
    base64_encode((unsigned char*)tmpBuf+200, 8, &pBuf);
    if (pBuf == NULL)   return NULL;
    strcpy(tmpBuf, pBuf);
    free(pBuf);
    (*env)->ReleaseStringUTFChars(env, encPwd, (char*)inStr);
    return (*env)->NewStringUTF(env, tmpBuf);
}

