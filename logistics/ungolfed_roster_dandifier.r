library(xml2)

# The XLS file is actually an HTML file, so we can parse it (the HTML) with
# XPath and get everything we need that way.
roster <- read_html(file.choose())

# Finds CRNs and Sections. They're the 2nd and 6th column in the headers for
# each section, respectively (hence td[2] and td[6]). The location of the
# section info within the HTML file can be found by looking for the column
# headers that say CRN or SEC in them, denoting that the CRN and SEC are listed
# in the row below.
# See also: get_items() for explanation of what the XPath does.
crns <- xml_find_all(roster, paste("//th[b='CRN']/../following-sibling::*[1]/td[2]", sep=""))
sections <- xml_find_all(roster, paste("(//th[b='SEC'])/../following-sibling::*[1]/td[6]", sep=""))

get_items <- function(item, columns, section_pos) {
# Retrieves all the items within a column for a section
# 
# Args:
#   item: The name of the column (as specified in columns). The name doesn't
#     actually matter. Columns are search by number.
#   columns: List of valid column names.
#   section_pos: The position of the section (e.g., 6 would mean the 6th section
#     from the top of the file) from which to retrieve columns.
# Returns:
#   The text of the items in the column (formatted as character())
    xml_text(xml_find_all(roster,
        # Find the location of the section by looking for the header for one of
        # the columns (Seq) within the section. Note that this is one XPath
        # statement, broken up into multiple rows for readability.
        paste("(//th[b='Seq'])[", section_pos, "]/",
              # Select all the rows (for the section) beneath the header. The
              # header is two rows tall, so we have to skip the first row. The
              # last row tells us how many students were printed, which is
              # unnecessary information, so we skip that row, as well.
              "../following-sibling::tr[position() > 1 and position() < last() - 1]/",
              # Select the column (by number; match returns the position of the
              # item within the list of column names) from which we'd like data
              "td[", match(item, columns) ,"]", sep=""
    )))
}

# Column names for columns 1 to 13 in the data table. The column names don't
# have to correspond with the names in the HTML; they're used for producing
# output.
col_names <- c("Seq", "SID", "Last Name", "First Name", "Level", "Units",
               "Class", "Major", "Grade", "Status", "Status Date", "Email")

write.csv(
    # "Loop" through each CRN/Section. For each section, get the columns of
    # data for the section and the CRN and name of the section as additional
    # columns. Attach these data to the bottom of an output table.
    Reduce(function(output, section_pos) {
        # anonymous function
        #
        # Attaches data for a single CRN/section to the bottom of the output
        # table.
        #
        # Args:
        #   output: The output data.frame (initialized as empty matrix, cf.
        #     empty matrix below)
        #   section_pos: The position of the section within the roster document
        #     (from seq(crns), below)
        # Returns:
        #   The output data.frame with data added from the specified section.

        # If the section doesn't have any students, skip it
        if(length(get_items("Seq", col_names, section_pos)) == 0) {
            # Set the names for all 14 columns in the output table and return
            # the output table
            return(output)
        }

        # Tack on rows for each section to rows for previous sections within the
        # same data.frame/output table
        rbind(output,
            data.frame(
                CRN = xml_text(crns[section_pos]),
                Section = xml_text(sections[section_pos]),
                # Call get_items(name, col_names, section_pos) on each column
                # (get the text from each row).
                # Also, set simplify to false to keep it as a named list (don't convert to matrix)
                sapply(col_names, FUN = get_items, col_names, section_pos, simplify=FALSE)))
        },
        # Provides a list of numbers for the length of the CRN list (i.e., the
        # equivalent of c(0, 1, 2, 3, 4, 5, 6, 7, ..., n). This is what we're
        # looping through.
        seq(crns),
        # Create an empty matrix with 14 columns to later use as a data.frame to
        # which to add data
        matrix(NA,0,14)),
    "roster.csv",
    row.names=FALSE
)
