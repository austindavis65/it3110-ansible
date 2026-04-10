# Scenario: Secure User and Group Management for a Financial Institution
## Background:

You are a systems administrator tasked with setting up user and group management for a financial institution. The institution requires strict access control measures to protect sensitive financial data and comply with regulatory requirements. You will utilize an ansible playbook to complete most of the following:

## Requirements:

### User Groups:
Create three user groups: executives, analysts, and administrators.
Assign users to these groups based on their roles:
executives: CEO, CFO, CIO
analysts: Financial Analysts (x5)
administrators: System Administrators (x2)
### User Accounts:
Create user accounts for each individual specified above, ensuring they are members of their respective primary groups as well as the appropriate secondary groups.
All users should have unique, randomly generated passwords for enhanced security.
### Work Directories:
Create separate work directories for each user group under /financial/work, ensuring strict permissions and ownership settings.
Work directories should be owned by the respective group and accessible only to members of that group.
New files created in that directory should automatically be owned by the group. Only owners of the file should be able to delete.
### Security Measures:
Enforce a strong password policy for user accounts, requiring a minimum length of 12 characters, including a combination of uppercase and lowercase letters, numbers, and special characters. (Hint: the package libpam-pwquality)
Implement SSH key-based authentication for system administrators to enhance security when accessing the server remotely.
### Tear down:
Make sure you can undo all the changes from above, by running another playbook.
## Documentation:
Provide detailed documentation explaining the rationale behind your configuration choices, including security enhancements and access control measures implemented.
Demonstrate that your playbook works.
Upload your documentation to canvas.
