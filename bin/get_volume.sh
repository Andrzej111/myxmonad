#!/bin/bash
amixer get Master | grep -Po '\d+%'

