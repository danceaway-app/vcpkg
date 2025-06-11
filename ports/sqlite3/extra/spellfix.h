/*
** Copyright (c) 2025 DANCE-7SEQUOIAS LTD
**
*************************************************************************
**
** This module implements the spellfix1 VIRTUAL TABLE that can be used
** to search a large vocabulary for close matches.  See separate
** documentation (http://www.sqlite.org/spellfix1.html) for details.
*/

#ifndef _SPELLFIX_H
#define _SPELLFIX_H 1

#ifdef __cplusplus
extern "C" {
#endif

int sqlite3_spellfix_init(sqlite3 *db, char **pzErrMsg,
                          const sqlite3_api_routines *pApi);

#ifdef __cplusplus
} /* end of the 'extern "C"' block */
#endif

#endif /* _SPELLFIX_H */
