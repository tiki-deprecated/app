/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
-- -----------------------------------------------------------------------
-- DATA FETCH PART
-- -----------------------------------------------------------------------
CREATE TABLE data_fetch_part (
    part_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ext_id TEXT NOT NULL,
    account_id INTEGER NOT NULL,
    api_enum TEXT NOT NULL,
    obj_json TEXT,
    created_epoch INTEGER NOT NULL,
    modified_epoch INTEGER NOT NULL
);

CREATE UNIQUE INDEX data_fetch_part_idx ON data_fetch_part(ext_id, account_id);

-- -----------------------------------------------------------------------
-- DATA FETCH LAST
-- -----------------------------------------------------------------------
CREATE TABLE data_fetch_last (
    fetch_id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INTEGER NOT NULL,
    api_enum TEXT NOT NULL,
    fetched_epoch INTEGER NOT NULL
);

CREATE UNIQUE INDEX data_fetch_last_idx ON data_fetch_last(account_id, api_enum);