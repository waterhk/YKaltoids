//
//
// YALog.h -- 1.0.4
//
//
// Copyright (c) 2009-2011 Arne Harren <ah@0xc0.de>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// YALog.h has been updated to reflect naming conventions for altoids

//
// YALog -- a set of quick logging macros for LibComponentLogging.
//
// YALog just consists of this small header file which defines a short logging
// macro for every log level of LibComponentLogging, e.g. YALogError() for error
// messages and YALogTrace() for trace messages. Additionally, all logging macros
// take the current log component from the kYALogComponent preprocessor define
// which can be (re)defined in your application at a file-level, section-based,
// or global scope. If you want to include the log component in your logging
// statements instead of using the kYALogComponent define, you can use the _c
// variants of the logging macros which take the log component as the first
// argument, e.g. YALogError_c(lcl_cMain), YALogTrace_c(lcl_cMain, @"message").
//


//
// YALogXXX macros which use the currently active kYALogComponent
//

#define YALogCritical(...)                                                        \
lcl_log(kYALogComponent, lcl_vCritical, @"" __VA_ARGS__)

#define YALogError(...)                                                           \
lcl_log(kYALogComponent, lcl_vError, @"" __VA_ARGS__)

#define YALogWarning(...)                                                         \
lcl_log(kYALogComponent, lcl_vWarning, @"" __VA_ARGS__)

#define YALogInfo(...)                                                            \
lcl_log(kYALogComponent, lcl_vInfo, @"" __VA_ARGS__)

#define YALogDebug(...)                                                           \
lcl_log(kYALogComponent, lcl_vDebug, @"" __VA_ARGS__)

#define YALogTrace(...)                                                           \
lcl_log(kYALogComponent, lcl_vTrace, @"" __VA_ARGS__)


//
// YALogXXX-_c macros which take the log component as first argument
//


#define YALogCritical_c(log_component, ...)                                       \
lcl_log(log_component, lcl_vCritical, @"" __VA_ARGS__)

#define YALogError_c(log_component, ...)                                          \
lcl_log(log_component, lcl_vError, @"" __VA_ARGS__)

#define YALogWarning_c(log_component, ...)                                        \
lcl_log(log_component, lcl_vWarning, @"" __VA_ARGS__)

#define YALogInfo_c(log_component, ...)                                           \
lcl_log(log_component, lcl_vInfo, @"" __VA_ARGS__)

#define YALogDebug_c(log_component, ...)                                          \
lcl_log(log_component, lcl_vDebug, @"" __VA_ARGS__)

#define YALogTrace_c(log_component, ...)                                          \
lcl_log(log_component, lcl_vTrace, @"" __VA_ARGS__)
