echo "Comparing local branches to GitHub..."
local_branches=$(git branch --list | grep -vE " main| master| develop" | sed 's/\* //')
merged_branches=$(gh pr list --state merged -L 1000 --json headRefName | jq -r '.[] | .headRefName')

echo "Merged local branches:"
merged_to_delete=()
for branch in $(echo "$local_branches"); do 
  if echo "$merged_branches" | grep -q "^$branch$"; then
    echo "$branch"
    merged_to_delete+=("$branch")
  fi
done

if [ ${#merged_to_delete[@]} -gt 0 ]; then
  echo -n "Delete these merged local branches? (y/n): "
  read answer
  if [ "$answer" = "y" ]; then
    for branch in "${merged_to_delete[@]}"; do
      git branch -D "$branch"
    done
  else
    echo "No branches were deleted."
  fi
else
  echo "None"
fi
