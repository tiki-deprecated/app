/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
-- -----------------------------------------------------------------------
-- DATA FETCH MESSAGES
-- -----------------------------------------------------------------------
CREATE TABLE data_fetch_message (
    data_fetch_message_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ext_message_id TEXT NOT NULL,
    account TEXT,
    UNIQUE (ext_message_id, account)
);
