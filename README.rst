cijoe-pkg-rocksdb: cijoe extractor for rocksdb workloads
========================================================

Install CIJOE
=============

Install cijoe system-wide via pip

.. code-block:: bash

  sudo pip install cijoe

Or install it user-level:

.. code-block:: bash

  pip install --user cijoe

.. note::

  When doing user-level install, then include the :code:`pip` binary install
  path in your :code:`PATH` definition. For example
  :code:`PATH="$PATH:$HOME/.local/bin"`


Install rocksdb extractor package
=================================

Install cijoe-pkg-rocksdb system wide

.. code-block:: bash

  sudo make install-system

Or install it user-level (follow cijoe installation)

.. code-block:: bash

  make install

Create environment definition for CIJOE
=======================================

Run CIJOE interactively and define the target environment:

.. code-block:: bash

  # Start cijoe
  cijoe

  # Use refence definitions as a template for defining your environment
  cat envs/refenv-zns.sh > target_env.sh

  # Open up your favorite editor and modify accordingly
  vim target_env.sh

Running tests
=============

Start the test-runner and view the report:

.. code-block:: bash

  # Directory containing results from cijoe run with `db_bench*` files
  RESULTS=/path/to/dir/with/db_bench/files/

  # Run using the testplan for Zoned devices
  cij_extractor \
      --extractor rocksdb_db_bench
      --output $RESULTS

  # metrics.yml files will be dumped for each test case containing
  # `db_bench*` files

Example of how the extractor can be used with the included RocksDB example plan.
This will generate a file called `metrics.yml` in the output directory for
the rocksdb_example test.

.. code-block:: bash

  OUTPUT=$(mktemp -d)
  cij_runner --testplan ./testplans/rocksdb_example.plan --env ./your_target_env.sh --output $OUTPUT
  cij_extractor --extractor rocksdb_db_bench --output $OUTPUT

If you find bugs or need help then feel free to submit an `Issue`_. If you want
to get involved head over to the `GitHub page`_ to get the source code and
submit a `Pull request`_ with your changes.

.. _GitHub page: https://github.com/refenv/cijoe-pkg-rocksdb
.. _Pull request: https://github.com/refenv/cijoe-pkg-rocksdb/pulls
.. _Issue: https://github.com/refenv/cijoe-pkg-rocksdb/issues
