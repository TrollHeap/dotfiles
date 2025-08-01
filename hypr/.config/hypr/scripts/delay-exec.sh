#!/bin/bash

vol=$(pamixer --get-volume)
eww update get_vol="$vol"
