#!/usr/bin/env bash

task_summary() {
    echo -e "\033[0;34m  ******************************************************"
    echo -e "  *                                                    *"
    echo -e "  *   🖥️  Task Summary - $(date '+%A, %d %B %Y')   *"
    echo -e "  *                                                    *"
    echo -e "  ******************************************************\033[0m"
    echo ""
    echo -e "\033[0;35m📋 Useful TaskWarrior Aliases:\033[0m"
    echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
    echo -e "\033[0;36m| Alias             | Description                                        |\033[0m"
    echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
    echo -e "\033[0;36m| today             | Tasks due today                                    |\033[0m"
    echo -e "\033[0;36m| urgent            | Tasks with urgency > 9                             |\033[0m"
    echo -e "\033[0;36m| soon              | Tasks due in the next 3 days                       |\033[0m"
    echo -e "\033[0;36m| progress          | Display a weekly burndown graph                    |\033[0m"
    echo -e "\033[0;36m+-------------------+----------------------------------------------------+\033[0m"
    echo ""
    echo -e "\033[0;33m🗓️  Tasks for Today:\033[0m"
    task today
    echo ""
    echo -e "\033[0;32m✅ Keep pushing forward! 🚀\033[0m"
}

task_summary
