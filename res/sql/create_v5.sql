/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
-- -----------------------------------------------------------------------
-- DATA PUSH QUEUE
-- -----------------------------------------------------------------------
CREATE TABLE data_push_queue (
    queue_id INTEGER PRIMARY KEY AUTOINCREMENT,
    from_type TEXT NOT NULL,
    from_value TEXT NOT NULL,
    to_type TEXT NOT NULL,
    to_value TEXT NOT NULL,
    fingerprint TEXT NOT NULL,
    created_epoch INTEGER NOT NULL
);
