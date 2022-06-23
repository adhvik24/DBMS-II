#include <bits/stdc++.h>

using namespace std;

int main()
{
    string abstract = "";
    string Main_author_Name = "";
    string First_Name = "";
    string Last_Name = "";

    string Title = "";
    string Venue = "";
    string Co_author_Name = "";
    string year = "";
    string paper_ind = "";

    int Year;
    int Paper_Id;
    int Ref_Paper_ID;

    std::vector<string> Authors;
    std::vector<string> Pub_Venue;
    std::vector<string> Co_authors;
    vector<string> Reference_ids;

    set<string> reference_paper_ids;
    set<string>::iterator set_it;

    set<string> co_authors;

    vector<string>::iterator it;

    map<string, int> Publisher_Map;
    map<string, int> Author_Map;

    map<string, int>::iterator it1;
    map<string, int>::iterator it2;

    int PUBLISHER_ID = 0;
    int AUTHOR_ID = 0;

    int count1 = 0;
    int count2 = 0;

    char ch;

    std::string line;
    std::ifstream myFile("source.txt");
    std::ofstream Paper_details("Paper_data.csv");
    std::ofstream author_details("Author_data.csv");
    std::ofstream Co_author_details("Co_Author_data.csv");
    std::ofstream Citation_details("citation.csv");
    std::ofstream Publication_details("publication.csv");

    char Line[300];
    while (getline(myFile, line))
    {

        // cout << line << endl;
        int i = 2;
        if (line[0] == '#')
        {

            if (line[1] == '*')
            {
                if (count1 != count2)
                {
                    it1 = Author_Map.find(Main_author_Name);
                    it2 = Publisher_Map.find(Venue);
                    if (abstract == "")
                        abstract = "Not Available";
                    Paper_details << paper_ind << "\t" << it1->second << "\t" << it2->second << "\t" << year << "\t" << Title << "\t" << abstract << endl;
                    count2 = count1;

                    int rank = 1;

                    co_authors.erase(Main_author_Name);

                    set_it = co_authors.begin();
                    while (set_it != co_authors.end())
                    {
                        it1 = Author_Map.find(*set_it);
                        Co_author_details << paper_ind << "\t" << it1->second << "\t" << rank << endl;

                        set_it++;
                        rank++;
                    }

                    co_authors.clear();

                    while (!Reference_ids.empty())
                    {
                        if (Reference_ids.back().erase(0, 2) != paper_ind)
                            Citation_details << paper_ind << "\t" << Reference_ids.back() << endl;

                        Reference_ids.pop_back();
                        /* code */
                    }
                }

                count1++;

                abstract = "";
                year = "";
                // paper_ind = "";
                Main_author_Name = "";

                Title = line.erase(0, 2);
                // fprintf(Wptr1,"%s\n",&abstract[0]);
            }

            else if (line[1] == '@')
            {
                line = line.erase(0, 2);
                if (line.length() != 0)
                {
                    First_Name = "";
                    Last_Name = "";

                    char *token = strtok(&line[0], ",");

                    int count = 0;
                    Main_author_Name = token;

                    co_authors.insert(Main_author_Name);

                    std::size_t pos = Main_author_Name.find(" ");
                    First_Name = Main_author_Name.substr(0, pos);

                    if (First_Name == "")
                    {

                        if (pos < Main_author_Name.length())
                        {
                            Last_Name = Main_author_Name.substr(pos + 1, std::string::npos);

                            pos = Last_Name.find(" ");

                            First_Name = Last_Name.substr(0, pos);

                            Last_Name = "";
                        }
                    }

                    if (pos < Main_author_Name.length())
                        Last_Name = Main_author_Name.substr(pos + 1, std::string::npos);

                    if (First_Name == "")
                    {
                        cout << paper_ind << ":" << Main_author_Name << endl;
                    }

                    token = strtok(NULL, ",");

                    // it = std::find(Authors.begin(), Authors.end(), Main_author_Name);
                    it1 = Author_Map.find(Main_author_Name);

                    if (it1 == Author_Map.end())
                    {
                        // Authors.push_back(Main_author_Name);
                        AUTHOR_ID += 1;
                        Author_Map[Main_author_Name] = AUTHOR_ID;

                        author_details << AUTHOR_ID << "\t" << First_Name << "\t" << Last_Name << "\t" << First_Name << "@gmail.com" << endl;
                    }

                    while (token != NULL)
                    {
                        Co_author_Name = token;
                        //   it = std::find(Authors.begin(), Authors.end(), Co_author_Name);
                        it1 = Author_Map.find(Co_author_Name);

                        if (it1 == Author_Map.end())
                        {

                            First_Name = "";
                            Last_Name = "";

                            std::size_t pos = Co_author_Name.find(" ");
                            First_Name = Co_author_Name.substr(0, pos);

                            if (First_Name == "")
                            {

                                if (pos < Co_author_Name.length())
                                {
                                    Last_Name = Co_author_Name.substr(pos + 1, std::string::npos);

                                    pos = Last_Name.find(" ");

                                    First_Name = Last_Name.substr(0, pos);

                                    Last_Name = "";
                                }
                            }

                            if (pos < Co_author_Name.length())
                                Last_Name = Co_author_Name.substr(pos + 1, std::string::npos);

                            // Authors.push_back(Co_author_Name);
                            AUTHOR_ID += 1;
                            Author_Map[Co_author_Name] = AUTHOR_ID;

                            if (First_Name == "")
                            {
                                cout << paper_ind << ":" << Co_author_Name << endl;
                            }
                            author_details << AUTHOR_ID << "\t" << First_Name << "\t" << Last_Name << "\t" << First_Name << "@gmail.com" << endl;
                        }

                        co_authors.insert(Co_author_Name);

                        // cout << Main_author_Name << endl;
                        token = strtok(NULL, ",");
                    }
                    /* code */
                }

                else
                {
                    Main_author_Name = "NA";
                    // it = std::find(Authors.begin(), Authors.end(), Main_author_Name);
                    it1 = Author_Map.find(Main_author_Name);

                    if (it1 == Author_Map.end())
                    {
                        // Authors.push_back(Main_author_Name);
                        AUTHOR_ID += 1;
                        Author_Map[Main_author_Name] = AUTHOR_ID;

                        author_details << AUTHOR_ID << "\t" << Main_author_Name << "\t"
                                       << ""
                                       << "\t"
                                       << "NA" << endl;
                    }
                }
            }

            else if (line[1] == 't')
            {
                year = line.erase(0, 2);
            }

            else if (line[1] == 'c')
            {
                Venue = line.erase(0, 2);
                it1 = Publisher_Map.find(Venue);

                if (it1 == Publisher_Map.end())
                {
                    // Authors.push_back(Main_author_Name);
                    PUBLISHER_ID += 1;
                    Publisher_Map[Venue] = PUBLISHER_ID;
                    if (Venue == "")
                    {
                        Publication_details << PUBLISHER_ID << "\t"
                                            << "Online"
                                            << "\t"
                                            << "10" << endl;
                    }
                    else
                    {
                        Publication_details << PUBLISHER_ID << "\t" << Venue << "\t"
                                            << "10" << endl;
                    }
                }
            }

            else if (line[1] == '%')
            {
                char *token = strtok(&line[0], ",");

                while (token != NULL)
                {
                    Reference_ids.push_back(token);
                    token = strtok(NULL, ",");
                    /* code */
                }
            }

            else if (line[1] == 'i')
            {
                paper_ind = line.erase(0, 6);
            }

            else if (line[1] == '!')
            {

                abstract = line.erase(0, 2);

                // fprintf(Wptr1,"%s\n",&abstract[0]);
            }
        }
        /* code */
    }

    if (count1 != count2)
    {
        it1 = Author_Map.find(Main_author_Name);
        it2 = Publisher_Map.find(Venue);
        if (abstract == "")
            abstract = "Not Available";
        Paper_details << paper_ind << "\t" << it1->second << "\t" << it2->second << "\t" << year << "\t" << Title << "\t" << abstract << endl;
        count2 = count1;

        int rank = 1;
        set_it = co_authors.begin();
        while (set_it != co_authors.end())
        {
            it1 = Author_Map.find(*set_it);
            Co_author_details << paper_ind << "\t" << it1->second << "\t" << rank << endl;

            set_it++;
            rank++;
        }

        co_authors.clear();

        while (!Reference_ids.empty())
        {
            if (Reference_ids.back().erase(0, 2) != paper_ind)
                Citation_details << paper_ind << "\t" << Reference_ids.back() << endl;
            Reference_ids.pop_back();
            /* code */
        }
    }
}
