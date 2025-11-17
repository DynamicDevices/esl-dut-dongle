# Collaboration Guide for Design Specification

This guide explains how to collaborate on answering the design specification questionnaire.

## Option 1: Markdown File (Recommended) ✅

**File:** `DESIGN_SPEC_ANSWERS.md`

**Pros:**
- ✅ Easy to read and edit
- ✅ Version controlled in git
- ✅ Can be viewed on GitHub
- ✅ I can read it directly from the repository
- ✅ Supports comments and discussions via git commits

**How to use:**
1. Both collaborators edit `DESIGN_SPEC_ANSWERS.md`
2. Use git to merge changes
3. I can automatically read and parse the answers
4. Easy to track changes via git history

**Best for:** Git-based collaboration, version control, easy parsing

---

## Option 2: YAML File (Structured Data) ✅

**File:** `DESIGN_SPEC_ANSWERS.yaml`

**Pros:**
- ✅ Structured format, easy to parse programmatically
- ✅ Can be validated for completeness
- ✅ Version controlled in git
- ✅ I can read and parse automatically
- ✅ Can generate reports/summaries easily

**How to use:**
1. Edit the YAML file with answers
2. Commit to git
3. I can parse and validate automatically
4. Can generate design spec from YAML

**Best for:** Automated processing, structured data, validation

---

## Option 3: GitHub Issues/Discussions

**Pros:**
- ✅ Built-in collaboration features
- ✅ Comments and discussions
- ✅ Can reference in commits
- ✅ I can read via GitHub API (if needed)

**Cons:**
- ⚠️ Less structured than files
- ⚠️ Harder to parse automatically
- ⚠️ Requires GitHub API access

**How to use:**
1. Create GitHub Issue for each question or category
2. Discuss and answer in comments
3. I can read issues if needed
4. Update markdown/YAML file with final answers

**Best for:** Discussion and collaboration, less structured

---

## Option 4: Google Docs (Not Recommended) ❌

**Why not recommended:**
- ❌ I cannot directly access Google Docs
- ❌ Requires manual export/import
- ❌ Not version controlled
- ❌ Harder to integrate with project

**If you must use Google Docs:**
1. Export to Markdown or YAML when done
2. Commit to repository
3. I can then read the file

**Better alternative:** Use GitHub's built-in markdown editor or VS Code with Live Share

---

## Recommended Workflow

### Step 1: Choose Format
- **Primary:** Use `DESIGN_SPEC_ANSWERS.md` (markdown)
- **Secondary:** Use `DESIGN_SPEC_ANSWERS.yaml` (structured)

### Step 2: Collaborate
1. Both collaborators clone repository
2. Edit the markdown file locally
3. Commit and push changes
4. Resolve conflicts via git merge
5. Or use GitHub's web editor for simple edits

### Step 3: Review
1. Review answers together
2. Ensure all critical questions answered
3. Verify hardware requirements

### Step 4: Generate Design Spec
1. I can read the answers file automatically
2. Generate design specification document
3. Validate completeness

---

## Git Collaboration Tips

### For Simple Collaboration:
```bash
# Person A
git pull
# Edit DESIGN_SPEC_ANSWERS.md
git add DESIGN_SPEC_ANSWERS.md
git commit -m "Answer questions 1-5"
git push

# Person B
git pull
# Edit DESIGN_SPEC_ANSWERS.md
git add DESIGN_SPEC_ANSWERS.md
git commit -m "Answer questions 6-10"
git push
```

### For Parallel Work:
- Use separate branches
- Merge frequently
- Resolve conflicts early

### Using GitHub Web Editor:
1. Go to file on GitHub
2. Click "Edit" button
3. Make changes
4. Commit directly (creates commit automatically)
5. Other person can pull changes

---

## Answer Format Guidelines

### For Markdown File:
- Use checkboxes: `[ ]` or `[x]`
- Fill in rationale sections
- Add notes where needed
- Keep answers clear and concise

### For YAML File:
- Use proper YAML syntax
- Fill in string values
- Use arrays for multiple selections
- Keep structure consistent

---

## Validation

Once answers are complete, I can:
1. Read the answers file automatically
2. Validate that all questions are answered
3. Check for consistency
4. Generate design specification document
5. Flag any missing critical information

---

## Next Steps

1. **Choose collaboration method** (recommend markdown file)
2. **Start answering questions** in `DESIGN_SPEC_ANSWERS.md`
3. **Collaborate via git** or GitHub web editor
4. **Notify when complete** - I can then read and generate design spec

---

## Questions?

If you need help with:
- Git collaboration workflow
- File format questions
- Parsing answers automatically
- Generating design spec from answers

Just ask!

