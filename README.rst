tutor-contrib-ltistore
######################

This is a Tutor plugin that enables the Open edX `LTI Store`_ application.
It installs the `openedx-ltistore` Django app, applies the Tutor patches
needed to wire it into Open edX, and makes reusable LTI configuration
available from Django Admin.

What is LTI Store?
******************

The Reusable LTI Store centralizes LTI configuration in Django Admin.
Course authors can then reference those reusable configurations from Studio
instead of entering the same tool credentials repeatedly on every LTI block.
That reduces copy/paste, lowers the risk of configuration errors, and makes
updates easier because a change in the central configuration applies to every
block that uses it.

The feature is designed for LTI 1.3 integrations and is especially useful
when multiple courses use the same external tool.

What is it for?
***************

Use LTI Store when you want site operators to manage LTI tool credentials in
one place and course authors to reuse those credentials from Studio through
the LTI Consumer component.

In practice, an administrator creates a reusable configuration in Django
Admin, gets the configuration's filter key, and the course author points the
LTI Consumer component at that key. The course block no longer needs the full
set of tool credentials, and future edits to the centralized configuration are
picked up everywhere it is referenced.

Installation
************

.. code-block:: bash

    pip install tutor-contrib-ltistore

Usage
*****

.. code-block:: bash

    tutor plugins enable ltistore

.. _LTI Store: https://docs.openedx.org/en/latest/site_ops/how-tos/setup_lti_store.html


License
*******

This software is licensed under the terms of the AGPLv3.
