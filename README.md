Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const SizedBox(
                                    height: 200,
                                    width: 350,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: 50, left: 30),
                                          child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: CircleAvatar(),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 40),
                                              child: Text(
                                                'Student name',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Caveat'),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 40),
                                              child: Text(
                                                'Roll Number',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Caveat'),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 40),
                                              child: Text(
                                                'Student name',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Caveat'),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, left: 40),
                                              child: Text(
                                                'Place',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Caveat'),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );